class Pipeline
  def initialize(input)
    schema = PipelineSchema.(input)
    @name = schema[:name]
    @size = schema[:size]
    @tasks = schema[:tasks].map { |t| Task.new(t) }
    @base = schema[:base]

    @executor = Executor.new(schema[:executor], @base)
  end

  def ordered_tasks
    all_tasks = []
    @tasks.each do |task|
      if task.depends_on
        task.depends_on.each do |subtask|
          @tasks.each do |st|
            if st.name == subtask
              all_tasks.append(st)
            end
          end
        end
      else
        all_tasks.append(task)
      end
    end

    all_tasks
  end

  def start!
    tasks = ordered_tasks
    begin
      @executor.runner.execute!(tasks)
    ensure
      @executor.runner.clean!
    end
  end
end