# frozen_string_literal: true

every 1.day do
  rake 'calculate_video_storage_usage'
end

every 1.hour do
  rake 'get_live_stream_stats'
end
