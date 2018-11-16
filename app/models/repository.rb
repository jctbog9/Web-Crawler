class Repository < ApplicationRecord
  validates :repository, null: false
  validates :description, null: false

  has_many :contributors
end
