require_relative "../executors/docker"

# this class only provides a small executor abstraction.
class Executor
  def initialize(executor, base_image)
    if executor.eql?("docker")
      return DockerExecutor.new(base_image)
    end
  end
end