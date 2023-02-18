class Command
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

  def run(executor)
    begin
      executor.execute!(raw)
      @status = :done
    rescue => exp
      @status = :failed
      @error = exp.to_s
    end
  end
end