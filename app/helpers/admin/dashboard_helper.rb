module Admin::DashboardHelper
  def stream_size_limit
    @subscription&.stream_size ? "out of #{@subscription&.stream_size}" : ''
  end

  def live_streams_limit
    @subscription&.live_streams ? "out of #{@subscription&.live_streams}" : ''
  end

  def targets_limit
    @subscription&.targets ? "out of #{@subscription&.targets}" : ''
  end

  def video_storage_limit
    @subscription&.video_storage ? "/ #{@subscription&.video_storage} gb" : ''
  end

  def viewer_count_limit
    @subscription&.viewer_count ? "/ #{@subscription&.viewer_count}" : ''
  end
end
