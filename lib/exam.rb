class Exam
  require "exam/version"
  require "exam/suite"
  require "exam/task"

  attr_reader :suites

  def initialize(&block)
    @suites = []
    @timing = false
    instance_eval(&block)
  end

  def timing?
    @timing
  end

  private

  def suite(name, &block)
    @suites << Suite.new(name, &block)
  end

  def timing(choice)
    if choice == true || choice == :on
      @timing = true
    end
  end
end
