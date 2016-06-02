class Client < ActiveRecord::Base

  # associations

  belongs_to :user

  # enums

  enum status: [ :active, :inactive ]

  # validations

  validates :address, presence: true
  validates :name, presence: true
  validates :phone, presence: true
  validates :status, presence: true
  validates :user_id, presence: true

  # scopes

  def self.by_user(user)
    where(user_id: user)
  end

  # class methods

  def self.status_str(status)
    if statuses.include?(status)
      I18n.t("activerecord.attributes.client.statuses.#{status}")
    else
      I18n.t(:undefined)
    end
  end

end
