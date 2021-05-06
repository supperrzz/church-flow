class GenerateHlsJob < ApplicationJob
  queue_as :default

  def perform(media_sermon_id)
    media_sermon = Admin::MediaSermon.find_by(id: media_sermon_id)
    if media_sermon.present? && media_sermon.video.present?
      # Generating new Hls
      puts 'Started generating new HLS'
      input_key = media_sermon.video.id
      output_key_prefix = "mediasermon/#{media_sermon.id}/video/"
      # Pipeline id in AWS
      pipeline_id = '1592507063390-7ensc0'
      input_key = input_key
      region = ENV['S3_BUCKET_REGION']
      hls_64k_audio_preset_id = '1351620000001-200071'
      hls_0400k_preset_id     = '1351620000001-200050'
      hls_0600k_preset_id     = '1351620000001-200040'
      hls_1000k_preset_id     = '1351620000001-200030'
      hls_1500k_preset_id     = '1351620000001-200020'
      hls_2000k_preset_id     = '1351620000001-200010'
      segment_duration = '8'
      output_key_prefix = output_key_prefix # hls_outputs/17/video
      transcoder_client = Aws::ElasticTranscoder::Client.new(region: region)
      input = { key: input_key }
      output_key = SecureRandom.hex
      hls_audio = {
        key: 'hlsAudio/' + output_key,
        preset_id: hls_64k_audio_preset_id,
        segment_duration: segment_duration
      }

      hls_400k = {
        key: 'hls0400k/' + output_key,
        preset_id: hls_0400k_preset_id,
        segment_duration: segment_duration,
        thumbnail_pattern: 'hls0400k/thumbnails/thumbnail-{count}'
      }

      hls_600k = {
        key: 'hls0600k/' + output_key,
        preset_id: hls_0600k_preset_id,
        segment_duration: segment_duration,
        thumbnail_pattern: 'hls0600k/thumbnails/thumbnail-{count}'
      }

      hls_1000k = {
        key: 'hls1000k/' + output_key,
        preset_id: hls_1000k_preset_id,
        segment_duration: segment_duration,
        thumbnail_pattern: 'hls1000k/thumbnails/thumbnail-{count}'
      }

      hls_1500k = {
        key: 'hls1500k/' + output_key,
        preset_id: hls_1500k_preset_id,
        segment_duration: segment_duration,
        thumbnail_pattern: 'hls1500k/thumbnails/thumbnail-{count}'
      }

      hls_2000k = {
        key: 'hls2000k/' + output_key,
        preset_id: hls_2000k_preset_id,
        segment_duration: segment_duration,
        thumbnail_pattern: 'hls2000k/thumbnails/thumbnail-{count}'
      }
      outputs = [hls_audio, hls_400k, hls_600k , hls_1000k, hls_1500k, hls_2000k ]
      playlist = {
        name: 'hls_' + output_key,
        format: 'HLSv3',
        output_keys: outputs.map { |output| output[:key] }
      }

      job = transcoder_client.create_job(pipeline_id: pipeline_id,
                                         input: input,
                                         output_key_prefix: output_key_prefix,
                                         outputs: outputs,
                                         playlists: [playlist])[:job]
      # playlist_file_key = "#{output_key_prefix}/hls_#{output_key}.m3u8"
      puts 'HLS job has been created: ' + JSON.pretty_generate(job)
    else
      puts 'media sermon not found'
    end
  end
end