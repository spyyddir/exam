require "benchmark"

class Exam
  class Task
    attr_reader :command, :time

    def initialize(command)
      @command = command
      @success = false
    end

    def run
      puts " #{command} ".center(80, "=")
      @time = Benchmark.realtime do
        @success = system(@command)
      end
      puts
    end

    def success?
      @success
    end

    def <=>(other_task)
      -1 * (@time <=> other_task.time)
    end
  end
end