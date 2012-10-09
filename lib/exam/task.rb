class Exam
  class Task
    attr_reader :command

    def initialize(command)
      @command = command
    end
  end
end