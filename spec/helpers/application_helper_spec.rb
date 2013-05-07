require 'spec_helper'

describe ApplicationHelper do
	describe "mins_since_midnight" do
		it "should raise an ArgumentError if no argument is given" do
			expect{mins_since_midnight}.to raise_error(ArgumentError)
		end

		it "should correctly calculate the minutes since midnight given a string-time argument" do
			assert_equal 750, mins_since_midnight("12:30")
		end

	end
end