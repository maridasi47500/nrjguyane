class Weekday < ApplicationRecord
  has_and_belongs_to_many :emissions, :join_table => :hasweekdays
end
