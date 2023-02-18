class Task
  def initialize(task_schema)
    @schema = task_schema
    @name = task_schema[:name]
    @ignore_fail = task_schema[:ignore_fail]
    @commands = task_schema[:commands].map do |command|
      Command.new(command)
    end
  end
end