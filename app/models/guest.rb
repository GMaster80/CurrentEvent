# == Schema Information
#
# Table name: guests
#
#  id         :integer          not null, primary key
#  name       :string
#  companions :integer          default(0)
#  event_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Guest < ApplicationRecord
  belongs_to :event
  before_create :set_total
after_create :call_event


private
  def call_event
     self.event.calculate_progress(self.total)
  end

  def set_total 
    self.total =  self.total = 1 + self.companions
  end
end
