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
end
