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

  attr_accessor :fiber, :last_value

  def initialize(&block)
    self.fiber = Fiber.new do
      yield
      Godot.emit_signal :finished, true
    end
    Dialogue.current = self
  end

  def continue(val = true)
    fiber.resume(val)
  end

  def ___?
    last_value
  end

  def scene(sym)
    Godot.emit_signal :background, sym
  end
end
delegate Dialogue, :continue, :___?, :scene #


class Speaker
  class << self
    attr_accessor :all, :current

    def current=(speaker)
      current.temporary_face = nil if current
      @current = speaker
    end
  end
  self.all = []

  attr_accessor :name, :temporary_face, :permanent_face

  def initialize(name)
    self.name = name
    self.permanent_face = ''
    Speaker.all << self
  end

  def says(str)
    communicate :says, str
  end

  def asks(str, choices = { 'Yes' => true, 'No' => false })
    communicate :asks, str, choices
  end

  def with(face)
    self.permanent_face = ''
    self.temporary_face = face.to_s
  end

  def got(face)
    self.permanent_face = face.to_s
  end

  def face
    temporary_face || permanent_face
  end

  private
    def emit(key, args = {})
      Godot.emit_signal key, { name: name, face: face, **args }
    end

    def communicate(key, str, choices = {})
      emit key, { content: str, choices: choices }
      Dialogue.current.last_value = Fiber.yield
    end
end
delegate Speaker, :says, :asks, :with, :got #


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


module SymbolExt
  def ~@
    scene self
  end
end
Symbol.prepend SymbolExt


module StringExt
  def -@
    says self
  end

  def !@
    asks self
  end
end
String.prepend StringExt


def speakers(names)
  names.each{|name| Speaker.new(name) }
end
