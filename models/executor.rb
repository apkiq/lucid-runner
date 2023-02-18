require_relative "../executors/docker"

# this class only provides a small executor abstraction.
class Executor
  attr_accessor :runner

  def initialize(executor, base_image)
    if executor.eql?("docker")
      @runner = DockerExecutor.new(base_image)
    end
  end
end