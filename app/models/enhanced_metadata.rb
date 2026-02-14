class EnhancedMetadata
  def self.load(data)
    new(JSON.parse(data)) if data
  end

  def self.dump(data)
    case data
    when nil
      nil
    when self
      data.to_json
    else
      new(data).data.to_json
    end
  end

  attr_reader :data

  def initialize(data)
    @data = data
  end

  def name
    @name = @data.dig("data", "attributes", "name")
  end
end
