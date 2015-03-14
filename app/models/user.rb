class User < ActiveRecord::Base

  # constants

  ROLES = [:admin, :user]

  attr_accessor :password

  # validations
  validates :birth_date, presence: true
  validates :confirmed, inclusion: [false, true]
  validates :email, presence: true, uniqueness: true, email: true
  validates :name, presence: true
  validates :password, confirmation: true
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
  validates :role, presence: true

end
