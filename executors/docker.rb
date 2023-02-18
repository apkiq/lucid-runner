require "docker"

class DockerExecutor
  def initialize(base_image)
    @container = Docker::Container
      .create(
        'Cmd' => ['sleep 30'],
        'Image' => base_image)
  end
end