class Command
  attr_accessor :status

  def initialize(command)
    @raw = command
    @status = :awaiting
  end

  def with_sh
    [
      "/bin/sh",
      "-c",
      @raw
    ]
  end
end