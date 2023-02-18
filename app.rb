require "bunny"
require "dry/schema"

require_relative "./models/executor"
require_relative "./models/command"
require_relative "./schemas/task"
require_relative "./models/task"
require_relative "./models/pipeline"
require_relative "./schemas/pipeline"

input = YAML.load(File.read("tests/input.yml"))
pipeline = Pipeline.new(input)
pipeline.start!