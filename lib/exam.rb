# encoding: utf-8
$:.unshift File.dirname(__FILE__)

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

  def success_character
    "✔"
  end

  def failure_character
    "×"
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

    print_results

    if success?
      puts success_character*80
      puts " Build Success ".center(80, success_character)
      puts success_character*80
    else
      puts failure_character*80
      puts " Build Failed ".center(80, failure_character)
      puts failure_character*80
    end
  end

  private

  def print_results
    @suites.each do |suite|
      puts "#{suite.success? ? success_character : failure_character}#{" (#{suite.time}s)" if timing?} #{suite.name}"
      suite.tasks.sort.each do |task|
        print "  "
        puts "#{task.success? ? success_character : failure_character}#{" (#{task.time}s)" if timing?} #{task.command}"
      end
    end
    puts
  end

  def suite(name, &block)
    @suites << Suite.new(name, &block)
  end

  def timing(choice)
    if choice == true || choice == :on
      @timing = true
    end
  end
end
