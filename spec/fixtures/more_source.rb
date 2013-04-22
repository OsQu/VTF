class Foo
  def initialize(options = {})
    @options = options
  end

  def empty?
    @options.empty?
  end
end
