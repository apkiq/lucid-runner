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



if ENV.fetch("LUCID_ENV", "test").eql?("test")
  input = YAML.load(File.read("tests/input.yml"))
  pipeline = Pipeline.new(input)
  $logger.info(I18n.t("pipeline.loaded", name: pipeline.name))
  pipeline.start!
else
  begin
    conn = Bunny.new(ENV.fetch("AMQP_URL"))
    conn.start
  
    ch = conn.create_channel
    ch.confirm_select
  rescue
    sleep 5
    retry
  end
  q = ch.queue("lucid.events.payload")
  q.subscribe(manual_ack: true, block: true) do |delivery_info, metadata, payload|
    $logger.info(I18n.t("app.listening_rabbitmq"))

    payload = JSON.parse(
      payload,
      symbolize_names: true
    )

    pipeline = Pipeline.new(payload[:pipeline])
    $logger.info(I18n.t("pipeline.loaded", name: pipeline.name))
    pipeline.start!
    ch.ack(delivery_info.delivery_tag)
  end
end
