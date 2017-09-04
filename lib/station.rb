class Station

  def initialize(name, zone)
    @station = {name: name, zone: zone}
  end

  def name
    @station[:name]
  end

  def zone
    @station[:zone]
  end

end
