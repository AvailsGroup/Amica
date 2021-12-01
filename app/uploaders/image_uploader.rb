class ImageUploader < CarrierWave::Uploader::Base
  # -------------------------------- 解説1 ----------------------------------
  include CarrierWave::MiniMagick
  process resize_to_fit: [500, 500]


  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :cropped do
    process :crop
  end


  private
  def crop
    user = User.new
    manipulate! do |img|
      crop_x = user.image_x.to_i
      crop_y = user.image_y.to_i
      crop_w = user.image_w.to_i
      crop_h = user.image_h.to_i

      img.crop "#{crop_w}x#{crop_h}+#{crop_x}+#{crop_y}"
      img
    end


  end

end