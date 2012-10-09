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

  it "should run" do
    exam = Exam.new do
      suite "test" do
        task "ls"
      end
    end

    Exam::Suite.any_instance.should_receive(:run)
    Exam::Suite.any_instance.stub(:success?).and_return(true)

    exam.run
    exam.success?.should == true
  end

  it "should allow running a suite by name" do
    exam = Exam.new do
      suite "test" do
        task "ls"
      end

      suite "not me" do

      end
    end

    exam.suites.first.should_receive :run
    exam.suites.last.should_not_receive :run

    exam.run("test")
  end

  it "should not have succeeded if any of its suites fail" do
    exam = Exam.new do
      suite "test" do
        task "ls"
      end

      suite "not me" do

      end
    end

    exam.suites.first.stub(:success? => false)
    exam.suites.last.stub(:success? => true)

    exam.run

    exam.success?.should == false
  end
end