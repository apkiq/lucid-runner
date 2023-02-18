require "bunny"
require "colorize"
require "dry/schema"
require "logger"
require "i18n"

require_relative "./models/executor"
require_relative "./models/command"
require_relative "./schemas/task"
require_relative "./models/task"
require_relative "./models/pipeline"
require_relative "./schemas/pipeline"

VERSION = "0.1.0"

I18n.load_path += Dir[File.expand_path("config/locales") + "/*.yml"]
I18n.default_locale = :en

$logger = Logger.new(STDOUT)
$logger.info(I18n.t("app.started", version: VERSION))

input = YAML.load(File.read("tests/input.yml"))
pipeline = Pipeline.new(input)
$logger.info(I18n.t("pipeline.loaded", name: pipeline.name))
pipeline.start!