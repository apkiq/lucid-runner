class Task
  attr_reader :depends_on
  attr_reader :commands

  def initialize(task_schema)
    @schema = task_schema
    @name = task_schema[:name]
    @ignore_fail = task_schema[:ignore_fail]
    @depends_on = task_schema[:depends_on]
    @commands = task_schema[:commands].map do |command|
      Command.new(command)
    end  
  end
end