# == Schema Information
#
# Table name: subscription_profiles
#
#  id                     :bigint           not null, primary key
#  active                 :boolean
#  consumed_live_streams  :integer          default(0)
#  consumed_stream_size   :integer          default(0)
#  consumed_targets       :integer          default(0)
#  consumed_video_storage :bigint           default(0)
#  consumed_viewer_count  :integer          default(0)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  stripe_card_id         :string
#  stripe_customer_id     :string
#  stripe_item_id         :string
#  stripe_subscription_id :string
#  subscription_id        :bigint
#  user_id                :bigint           not null
#
# Indexes
#
#  index_subscription_profiles_on_subscription_id  (subscription_id)
#  index_subscription_profiles_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (subscription_id => subscriptions.id)
#  fk_rails_...  (user_id => users.id)
#
class SubscriptionProfile < ApplicationRecord
  belongs_to :subscription, required: false
  belongs_to :user
end
