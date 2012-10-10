require File.expand_path("../../lib/exam.rb", __FILE__)

exam = Exam.new do
  suite "file operations" do
    task "ls"
    task "cd .."
    task "pwd"
    task "cd lsdfhskjdhfkjsdhk"
  end

  suite "all good" do
    task "ps"
  end
  
  suite "run_specs" do
    task "rspec" do
      "rspec ../spec"
    end
  end

  timing :on
end

exam.run