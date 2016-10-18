class TurnoverPerDay
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  store_in collection: "TurnoverPerDay", database: "turnovers"
  field :day
  field :turnovers

  def addTrunover(trunover)
    self.turnovers.push(trunover.mongoize)
  end
end
