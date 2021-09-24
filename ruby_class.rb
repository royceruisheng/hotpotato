

class Thing
  attr_reader :name

  def initialize(name)
    @name = name
    greet
  end

  def greet
    puts "hello, thing just got started!"
  end
end
