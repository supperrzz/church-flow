# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fname                  :string
#  invitation_completed   :boolean          default(FALSE)
#  invite_sent_at         :datetime
#  invite_token           :string
#  lname                  :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :integer          default("admin")
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: 1, super_admin: 2 }

  has_one :church
  has_one_attached :profile_picture

  accepts_nested_attributes_for :church

  validates_presence_of :fname, :lname

  after_create :create_church, if: :admin?

  def create_church
    c = Church.new(user: self)
    c.save(validate: false)
  end

  def create_invitation_token
    generate_invitation_token
    update_attribute :invite_sent_at, Time.now.utc unless invite_sent_at
    send_devise_notification(:invitation_instructions, @raw_invitation_token)
  end

  def generate_invitation_token
    raw, enc = Devise.token_generator.generate(self.class, :invite_token)
    @raw_invitation_token = raw
    update_attribute :invite_token, enc
  end

  def valid_invitation?
    invite_token.present? && invitation_period_valid?
  end

  def invitation_period_valid?
    time = invite_sent_at
    (time && time.utc >= 6.hours.ago)
  end

  def self.find_by_invitation_token(original_token, only_valid)
    invitation_token = Devise.token_generator.digest(self, :invite_token, original_token)

    invitable = find_or_initialize_with_error_by(:invite_token, invitation_token)
    invitable.errors.add(:invitation_token, :invalid) if invitable.invite_token && invitable.persisted? && !invitable.valid_invitation?
    invitable unless only_valid && invitable.errors.present?
  end
end
