class Sale < ActiveRecord::Base

  # associations

  belongs_to :client
  belongs_to :user

  has_many :sale_items, dependent: :destroy
  has_many :items, through: :sale_items

  # delegations

  delegate :name, to: :client, prefix: true

  # nested attributes

  accepts_nested_attributes_for :sale_items, allow_destroy: :true, reject_if: :all_blank

  # validations

  validates :client_id, presence: true
  validates :date, presence: true
  validates :user_id, presence: true

  # scopes

  def self.by_user(user)
    where(user_id: user)
  end

end
