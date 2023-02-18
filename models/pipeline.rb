class Pipeline
  def initialize(input)
    schema = PipelineSchema.(input)
    @name = schema[:name]
    @size = schema[:size]
    @tasks = schema[:tasks].map { |t| Task.new(t) }
    @base = schema[:base]

    @executor = Executor.new(schema[:executor], @base)
  end
end