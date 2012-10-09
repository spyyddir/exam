class Exam
  class Suite
    attr_reader :name, :tasks

    def initialize(name, &block)
      @name = name
      @tasks = []
      instance_eval(&block)
    end

    def run

    end

    def success?

    end

    private

    def task(command)
      @tasks << Task.new(command)
    end
  end
end