PipelineSchema = Dry::Schema.Params do
  required(:name).filled(:string)
  required(:executor).filled(:string)
  required(:base).filled(:string)
  
  required(:tasks).array(TaskSchema)
end