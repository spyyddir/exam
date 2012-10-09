class Exam
  require "exam/version"
  require "exam/suite"
  require "exam/task"

  attr_reader :suites

  def initialize(&block)
    @suites = []
    @timing = false
    @success = true
    instance_eval(&block)
  end

  def timing?
    @timing
  end

  def success?
    @success
  end

  def run(suite_name = :none)
    if suite_name == :none
      @suites.each do |suite|
        suite.run
        @success = false unless suite.success?
      end
    else
      to_run = @suites.detect {|suite| suite.name == suite_name}
      to_run.run
      @success = false unless to_run.success?
    end
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
