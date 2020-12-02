class ThumbnailGenerate

  def create(media_sermon)
    return if media_sermon.thumbnail.present?
    thumbnail = "media_sermon#{media_sermon.id}.jpeg"
    resp = system "ffmpeg -ss 00:00:05 -i '#{media_sermon.video.url}' -f image2 -vframes 1 '#{thumbnail}'"
    if resp
      media_sermon.update(thumbnail: File.open(thumbnail))
    end
  end
end