# = Redirects method calls to Xxx.current
#
#   `delegate Foo, :bar` means calling `bar` will forward to `Foo.current.bar`
#
def delegate(const, *keys)
  keys.each do |key|
    define_method(key) do |*args|
      const.current.send(key, *args)
    end
  end
end


class Dialogue
  class << self
    attr_accessor :current
  end

  attr_accessor :fiber

  def initialize(&block)
    self.fiber = Fiber.new do
      yield
      Godot.emit_signal :finished, true
    end
    Dialogue.current = self
  end

  def continue(val = nil)
    fiber.resume(val)
  end

  def listen!
    Fiber.yield
  end
end
delegate Dialogue, :continue #


class Speaker
  class << self
    attr_accessor :all, :current
  end
  self.all = []

  attr_accessor :name

  def initialize(name)
    self.name = name
    Speaker.all << self
  end

  def says(str)
    emit :says, { content: str }
    Dialogue.current.listen!
  end

  private
    def emit(key, args = {})
      Godot.emit_signal key, { name: name, **args }
    end
end
delegate Speaker, :says #


# = const_missing
#
#   `Alice;` sets `Speaker.current` to the Speaker instance named "Alice"
#
def Object.const_missing(name)
  speaker = Speaker.all.find{|s| s.name == name.to_s }
  if speaker
    Speaker.current = speaker
  else
    super
  end
end


def speakers(names)
  names.each{|name| Speaker.new(name) }
end
