class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable,
         :doorkeeper, :omniauthable, omniauth_providers: [:mlh]

  has_one :questionnaire
  has_many :access_grants, class_name: "Doorkeeper::AccessGrant",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks
  has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
                           foreign_key: :resource_owner_id,
                           dependent: :delete_all # or :destroy if you need callbacks

  validates_uniqueness_of :email

  after_create :queue_reminder_email

  enum role: { user: 0, event_tracking: 1, admin_limited_access: 2, admin: 3 }
  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    self.role ||= :user
  end

  def active_for_authentication?
    super && is_active
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def queue_reminder_email
    return if reminder_sent_at
    UserMailer.incomplete_reminder_email(id).deliver_later(wait: 1.day)
    update_attribute(:reminder_sent_at, Time.now)
  end

  def email=(value)
    super value.try(:downcase)
  end

  def safe_receive_weekly_report
    return false unless is_active
    receive_weekly_report
  end

  def first_name
    return "" if questionnaire.blank?
    questionnaire.first_name
  end

  def last_name
    return "" if questionnaire.blank?
    questionnaire.last_name
  end

  def full_name
    return email if questionnaire.blank?
    questionnaire.full_name
  end

  def self.from_omniauth(auth)
    matching_provider = where(provider: auth.provider, uid: auth.uid)
    matching_email = where(email: auth.info.email)
    matching_provider.or(matching_email).first_or_create do |user|
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def self.non_admins
    User.where.not(role: :admin).where.not(role: :admin_limited_access)
  end

  def self.without_questionnaire
    non_admins.left_outer_joins(:questionnaire).where(questionnaires: { id: nil })
  end
end
