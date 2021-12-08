class Appointment < ApplicationRecord
  belongs_to :professional

  validates :date, :name, :surname, :phone,  presence: true
  #validates :professional, presence: true
end
