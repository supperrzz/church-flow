class VideoUploader < Shrine
  # logic
  Attacher.validate do
    validate_mime_type %w[video/mp4 video/quicktime]
  end
end