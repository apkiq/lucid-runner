TaskSchema = Dry::Schema.Params do
  required(:name).filled(:string)
  required(:commands).array(:string)

  optional(:ignore_fail).filled(:bool)
  optional(:requirements).array(:string)
end