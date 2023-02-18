class Command
  def initialize(command)
    @raw = command
    @status = :awaiting
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