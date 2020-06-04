# == Schema Information
#
# Table name: admin_live_streams
#
#  id                :bigint           not null, primary key
#  mux_stream_key    :string
#  name              :string
#  playback_policy   :string
#  simulcast_targets :json             is an Array
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  church_id         :bigint           not null
#  mux_stream_id     :string
#
# Indexes
#
#  index_admin_live_streams_on_church_id  (church_id)
#
# Foreign Keys
#
#  fk_rails_...  (church_id => churches.id)
#
class Admin::LiveStream < ApplicationRecord
  belongs_to :church
  has_many :simulcast_targets, class_name: 'Admin::SimulcastTarget'

  PLAYBACK_POLICIES = [MuxRuby::PlaybackPolicy::PUBLIC, MuxRuby::PlaybackPolicy::SIGNED].freeze

  validates_inclusion_of :playback_policy, within: PLAYBACK_POLICIES
end
