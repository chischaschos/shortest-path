class Edge
  attr_reader :from, :to, :value

  def initialize(args)
    @from = args[:from]
    @to = args[:to]
    @value = args[:value]
  end

  def ==(other)
    other.value == value &&
      (other.from == from && other.to == to) ||
      (other.to == from && other.from == to)
  end
end
