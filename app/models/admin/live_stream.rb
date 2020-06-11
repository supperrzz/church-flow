# == Schema Information
#
# Table name: admin_live_streams
#
#  id              :bigint           not null, primary key
#  mux_stream_key  :string
#  name            :string
#  playback_policy :string
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  church_id       :bigint           not null
#  mux_stream_id   :string
#  playback_id     :string
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
  has_many :admin_simulcast_targets, class_name: 'Admin::SimulcastTarget',
           foreign_key: :admin_live_stream_id, dependent: :destroy, inverse_of: :admin_live_stream

  accepts_nested_attributes_for :admin_simulcast_targets, reject_if: :all_blank, allow_destroy: true

  PLAYBACK_POLICIES = [MuxRuby::PlaybackPolicy::PUBLIC, MuxRuby::PlaybackPolicy::SIGNED].freeze

  validates_inclusion_of :playback_policy, within: PLAYBACK_POLICIES
  validates_presence_of :name
end
