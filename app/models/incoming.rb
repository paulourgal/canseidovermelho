class Incoming < ActiveRecord::Base

  # associations

  belongs_to :user

  # scopes

  def self.by_user(user)
    where(user: user)
  end

end
