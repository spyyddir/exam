class Exam
  class Suite
    attr_reader :name, :tasks

    def initialize(name, &block)
      @name = name
      @tasks = []
      @success = true
      instance_eval(&block)
    end

    def run
      @tasks.each do |task|
        task.run
        @success = false unless task.success?
      end
    end

    def success?
      @success
    end

    private

    def task(command)
      @tasks << Task.new(command)
    end
  end
end