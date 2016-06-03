class Sale < ActiveRecord::Base

  # associations

  belongs_to :client
  belongs_to :user

  # delegations

  delegate :name, to: :client, prefix: true

  # validations

  validates :client_id, presence: true
  validates :date, presence: true
  validates :user_id, presence: true

  # scopes

  def self.by_user(user)
    where(user_id: user)
  end

end
