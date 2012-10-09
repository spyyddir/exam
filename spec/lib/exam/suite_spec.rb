require "rspec"
require "exam"

describe Exam::Suite do
  describe "#run" do
    it "should run its individual tasks"
  end

  describe "#success?" do
    it "should return true if all tasks have succeeded"
    it "should return false if any task fails"
  end
end