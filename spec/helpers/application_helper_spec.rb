require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe "format time" do
    it "formats time to month-date-year" do
      time = "2016-02-09T04:31:09Z"

      expect(format_time(time)).to eq "Feb-02-09 04:31AM"
    end
  end
end
