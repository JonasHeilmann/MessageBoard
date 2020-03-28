class Message < ApplicationRecord
  belongs_to :user

  # Validate that a title is provided when creating or editing an entry, throw an error if not
  validates :title, presence: true
end
