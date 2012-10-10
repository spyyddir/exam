require "benchmark"

class Exam
  class Task
    attr_reader :command, :time

    def initialize(command)
      @command = command
      @success = false
    end

    def run
      @time = Benchmark.realtime do
        @success = system(@command)
      end
    end

    def success?
      @success
    end

    def <=>(other_task)
      -1 * (@time <=> other_task.time)
    end
  end
end