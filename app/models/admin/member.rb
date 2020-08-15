# == Schema Information
#
# Table name: admin_members
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fname                  :string
#  lname                  :string
#  profile_picture_data   :text
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  church_id              :bigint           not null
#
# Indexes
#
#  index_admin_members_on_church_id             (church_id)
#  index_admin_members_on_email                 (email) UNIQUE
#  index_admin_members_on_reset_password_token  (reset_password_token) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (church_id => churches.id)
#
class Admin::Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :church
  # has_one_attached :profile_picture
  include ImageUploader::Attachment(:profile_picture)

  validates_presence_of :fname, :lname
end
