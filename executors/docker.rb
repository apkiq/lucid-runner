require "docker"
require "securerandom"

class DockerExecutor
  def initialize(base_image)
    @container_name = SecureRandom.uuid.to_s

    $logger.info(I18n.t(
      "docker.container.starting",
      base: base_image,
      container_name: @container_name
    ))

    @container = Docker::Container
      .create(
        "Name" => @container_name,
        "Image" => base_image,
        "Cmd" => [""]
      )
    
    @container.start
    $logger.info(I18n.t(
      "docker.container.started",
      container_name: @container_name
    ))

    self
  end

  def execute!(tasks)
    tasks.each do |task|
      $logger.warn(I18n.t("task.executing", name: task.name))
      task.commands.each do |command|
        res = @container.exec(command.with_sh, tty: true, stdout: true)
        res[0].each do |log_line|
          $logger.debug(log_line.chomp)
        end

        code = res[2].to_i
        unless task.ignore_fail
          unless code.zero?
            $logger.error(I18n.t("task.failed", name: task.name).colorize(:red))
            command.status = :failed

            return
          end
        end

        command.status = :done
      end
      $logger.info(I18n.t("task.executed", name: task.name))
    end
  end

  def clean!
    if @container
      $logger.info(I18n.t(
        "docker.container.cleaning",
        container_name: @container_name
      ))

      @container.delete(force: true)

      $logger.info(I18n.t(
        "docker.container.cleaned",
        container_name: @container_name
      ))
    end
  end
end