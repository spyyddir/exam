require "rspec"
require "exam"

describe Exam do
  it "should collect a set of test suites" do
    exam = Exam.new do
      suite "something" do
        task "whatever"
      end

      suite "other" do

      end
    end

    exam.suites.length.should == 2
    exam.suites.first.name.should == "something"
    exam.suites.last.name.should == "other"
  end

  it "should register tasks within suites" do
    exam = Exam.new do
      suite "something" do
        task "whatever"
        task "whenever"
        task "wherever"
        task "whoever"
      end
    end

    suite = exam.suites.first

    suite.tasks.length.should == 4
    suite.tasks[0].command.should == "whatever"
    suite.tasks[1].command.should == "whenever"
    suite.tasks[2].command.should == "wherever"
    suite.tasks[3].command.should == "whoever"
  end

  it "should register timing" do
    exam = Exam.new {}
    exam.timing?.should == false

    exam = Exam.new { timing :on }
    exam.timing?.should == true

    exam = Exam.new { timing true }
    exam.timing?.should == true

    exam = Exam.new { timing :off }
    exam.timing?.should == false

    exam = Exam.new { timing false }
    exam.timing?.should == false
  end
end