class Item < ActiveRecord::Base

  # association

  belongs_to :user

  # validations

  validates :user_id, presence: true

  # scopes

  def self.by_user(user)
    where(user_id: user)
  end

end
