# == Schema Information
#
# Table name: admin_simulcast_targets
#
#  id                   :bigint           not null, primary key
#  platform             :string
#  stream_key           :string
#  url                  :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  admin_live_stream_id :bigint           not null
#  mux_simulcast_id     :string
#
# Indexes
#
#  index_admin_simulcast_targets_on_admin_live_stream_id  (admin_live_stream_id)
#
# Foreign Keys
#
#  fk_rails_...  (admin_live_stream_id => admin_live_streams.id)
#
class Admin::SimulcastTarget < ApplicationRecord
  belongs_to :admin_live_stream, class_name: 'Admin::LiveStream'

  validates_presence_of :platform, :url, :stream_key

  before_destroy :delete_mux_simulcast

  def delete_mux_simulcast
    return unless mux_simulcast_id.present?

    live_api = MuxRuby::LiveStreamsApi.new
    live_api.delete_live_stream_simulcast_target(admin_live_stream.mux_stream_id, mux_simulcast_id)
  rescue MuxRuby::NotFoundError => _
    puts 'Already deleted.'
  end
end
