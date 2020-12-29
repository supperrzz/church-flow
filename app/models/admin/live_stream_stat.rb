# == Schema Information
#
# Table name: admin_live_stream_stats
#
#  id                   :bigint           not null, primary key
#  asset_created_at     :datetime
#  asset_duration       :float
#  delivered_seconds    :float
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  admin_live_stream_id :bigint           not null
#  asset_id             :string
#
# Indexes
#
#  index_admin_live_stream_stats_on_admin_live_stream_id  (admin_live_stream_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_live_stream_id => admin_live_streams.id)
#
class Admin::LiveStreamStat < ApplicationRecord
  include Discard::Model

  belongs_to :admin_live_stream, class_name: 'Admin::LiveStream'
end
