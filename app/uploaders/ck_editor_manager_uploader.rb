class CkEditorManagerUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :resized do
    process :resize_to_fit => [250, 250]
  end

  version :thumb do
    process :resize_to_fit => [50, 50]
  end

  # For images you might use something like this:
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
