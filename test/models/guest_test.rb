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
require "test_helper"

class GuestTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
