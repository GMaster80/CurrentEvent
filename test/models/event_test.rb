# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :string
#  event_date :datetime
#  address    :string
#  capacity   :integer          default(0)
#  available  :boolean          default(TRUE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#  progress   :integer          default(0)
#  message    :text
#
require "test_helper"

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
