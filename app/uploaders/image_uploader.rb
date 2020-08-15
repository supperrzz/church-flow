require "image_processing/mini_magick"

class ImageUploader < Shrine
  # logic
  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    {
      thumb: magick.resize_to_limit!(300, 300)
    }
  end
  Attacher.validate do
    validate_mime_type %w[image/jpg image/png image/jpeg]
  end
end