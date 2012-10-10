require "rspec"
require "exam"

describe Exam::Suite do
  describe "#run" do
    it "should run its individual tasks" do
      suite = Exam::Suite.new "name" do
        task "ls"
        task "woot"
        task "laugh"
      end

      suite.tasks.each do |task|
        task.should_receive(:run)
        task.stub(:success?)
      end

      suite.run
    end
  end

  describe "#success?" do
    it "should return true if all tasks have succeeded" do
      suite = Exam::Suite.new "name" do
        task "ls"
        task "woot"
        task "laugh"
      end

      suite.tasks.each do |task|
        task.stub(:run)
        task.stub(:success? => true)
      end

      suite.run

      suite.success?.should == true
    end

    it "should return false if any task fails" do
      suite = Exam::Suite.new "name" do
        task "ls"
        task "laugh"
      end

      suite.tasks.each do |task|
        task.stub(:run)
      end
      suite.tasks.first.stub(:success? => true)
      suite.tasks.last.stub(:success? => false)

      suite.run

      suite.success?.should == false
    end
  end

  describe "#time" do
    it "should return a total of the times of its tasks" do
      suite = Exam::Suite.new "name" do
        task "ls"
        task "laugh"
      end

      suite.tasks.each do |task|
        task.stub(:run)
      end
      suite.tasks.first.stub(:success? => true, time: 4.2)
      suite.tasks.last.stub(:success? => false, time: 1.2)

      suite.run

      suite.time.should == 5.4
    end
  end
end