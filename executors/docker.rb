require "docker"
require "securerandom"

class DockerExecutor
  def initialize(base_image)
    @container = Docker::Container
      .create(
        "Name" => SecureRandom.uuid.to_s,
        "Image" => base_image,
        "Cmd" => [""]
      )
    
    @container.start
    @container.exec(["ps", "aux"])

    self
  end

  def execute!(tasks)
    tasks.each do |task|
      task.commands.each do |command|
        @container.exec(command.with_sh, tty: true, stdout: true) do |stream|
          puts stream
        end
      end
    end
  end

  def clean!
    if @container
      @container.delete(force: true)
    end
  end
end