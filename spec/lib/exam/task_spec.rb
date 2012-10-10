require "rspec"
require "exam"

describe Exam::Task do
  describe "#initialize" do
    it "should init with its command" do
      task = Exam::Task.new("ls")
      task.command.should == "ls"
    end
  end

  describe "#run" do
    it "should use system to run its command" do
      task = Exam::Task.new("ls")
      task.should_receive(:system).with("ls")
      task.run
    end
  end

  describe "#success?" do
    it "should be true if the command exits success" do
      task = Exam::Task.new("ls")
      task.stub(:system).with("ls").and_return(true)
      task.run
      task.success?.should == true
    end

    it "should be true if the command exits success" do
      task = Exam::Task.new("ls")
      task.stub(:system).with("ls").and_return(false)
      task.run
      task.success?.should == false
    end
  end

  describe "#time" do
    it "should return how long the task took to execute" do
      Benchmark.stub(:realtime) do |&block|
        block.call
        3.23
      end

      task = Exam::Task.new("ls")
      task.should_receive(:system).with("ls")
      task.run

      task.time.should == 3.23
    end
  end

  describe "#sort" do
    it "should sort by time, descending" do
      t1 = Exam::Task.new("one")
      t2 = Exam::Task.new("two")
      t3 = Exam::Task.new("three")

      t1.instance_variable_set(:@time, 3.5)
      t2.instance_variable_set(:@time, 9.2)
      t3.instance_variable_set(:@time, 1.6)

      [t1, t2, t3].sort.should == [t2, t1, t3]
    end
  end
end