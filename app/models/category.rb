class Category < ActiveRecord::Base

  # assossiations

  belongs_to :user

  # enums

  enum kind: [ :incoming, :outgoing ]

  # validations

  validates :kind, presence: true
  validates :name, presence: true
  validates :user_id, presence: true

  # scopes

  def self.by_user(user)
    where(user: user)
  end

  def self.by_user_and_kind(user, kind)
    where(user: user, kind: kind)
  end

  # class methods

  def self.kind_str(kind)
    if kinds.include?(kind)
      I18n.t("activerecord.attributes.category.kinds.#{kind}")
    else
      I18n.t(:undefined)
    end
  end

end
