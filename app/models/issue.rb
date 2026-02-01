class Issue < ApplicationRecord
  belongs_to :user

  enum status: {
    open: 0,
    in_progress: 1,
    resolved: 2
  }

  enum priority: {
    low: 0,
    medium: 1,
    high: 2
  }

  validates :title, presence: true
  validates :status, presence: true
  validates :priority, presence: true
end

