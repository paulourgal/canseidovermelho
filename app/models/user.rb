class User < ActiveRecord::Base

  attr_accessor :password

  # validations
  validates :birth_date, presence: true
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :password, confirmation: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

end
