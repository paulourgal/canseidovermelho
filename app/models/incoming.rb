class Incoming < ActiveRecord::Base

  # associations

  belongs_to :user

  # validations

  validates :user_id, presence: true

  # scopes

  def self.by_user(user)
    where(user: user)
  end

end
