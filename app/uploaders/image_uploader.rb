class ImageUploader < CarrierWave::Uploader::Base
  # -------------------------------- 解説1 ----------------------------------
  include CarrierWave::MiniMagick
  process resize_to_fit: [500, 500]
  # ------------------------------------------------------------------------

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :resized do
    process :crop
    process resize_to_fill: [600, 600]
  end

  private

  def crop
    return if [model.image_x, model.image_y, model.image_w, model.image_h].all?
    manipulate! do |img|
      crop_x = model.image_x.to_i
      crop_y = model.image_y.to_i
      crop_w = model.image_w.to_i
      crop_h = model.image_h.to_i
      img.crop "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
      img = yield(img) if block_given?
      img
    end
  end

end