class ImageUploader < CarrierWave::Uploader::Base

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    "/images/fallback/" + [version_name, "default.png"].compact.join('')
  end

  def filename
    "#{Time.now.strftime('%Y%m%d%H%M%S')}.#{file.extension.downcase}" if original_filename
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  end