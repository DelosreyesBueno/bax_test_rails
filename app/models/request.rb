class Request < ApplicationRecord
  validates :name, :email, :key, :source, presence: true
end
