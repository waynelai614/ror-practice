class Turnover
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  store_in collection: "Turnover", database: "turnovers"

  field :day
  field :range
  field :number
  field :name
  field :startPrice
  field :highestPrice
  field :lowestPrice
  field :yesClose
  field :todayClose
  field :dealPrice
  field :dealDelta

  def mongoize
    {
      :range => self.range,
      :number => self.number,
      :name => self.name,
      :startPrice => self.startPrice,
      :highestPrice => self.highestPrice,
      :lowestPrice => self.lowestPrice,
      :yesClose => self.yesClose,
      :todayClose => self.todayClose,
      :dealPrice => self.dealPrice,
      :dealDelta => self.dealDelta
    }
  end

  class << self
    def demongoize(object)
      Turnover.new(
        range: object["range"],
        number: object["number"],
        name: object["name"],
        startPrice: object["startPrice"],
        highestPrice: object["highestPrice"],
        lowestPrice: object["lowestPrice"],
        yesClose: object["yesClose"],
        todayClose: object["todayClose"],
        dealPrice: object["dealPrice"],
        dealDelta: object["dealDelta"]
      )
    end

    def mongoize(object)
      case object
      when Turnover then object.mongoize
      else object
      end
    end
  end
end
