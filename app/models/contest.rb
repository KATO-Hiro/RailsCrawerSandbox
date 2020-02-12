class Contest < ApplicationRecord
  validates :name, presence: true
  validates :start_epoch_second, presence: true
  validates :duration_second, presence: true
  validates :title, presence: true
  validates :rate_change, presence: true
end
