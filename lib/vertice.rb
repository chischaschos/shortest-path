class Vertice
  attr_reader :from, :to, :value

  def initialize args
    @from = args[:from]
    @to = args[:to]
    @value = args[:value]
  end
end
