# class Turnover
#   include Mongoid::Document
# end
module Turnover
  class TurnoverPerDay
    include Mongoid::Document
    include Mongoid::Timestamps
    include Mongoid::Attributes::Dynamic
    store_in collection: "TurnoverPerDay", database: "turnovers"
    field :day, type: DateTime
    field :turnovers, type: Array
    embeds_many :Turnover

    def addTrunover(trunover)
      self.turnovers.push(trunover.mongoize)
    end

  end


  class Turnover
    include Mongoid::Document
    embedded_in :TurnoverPerDay

    # field :range, type: BigDecimal
    # field :number, type: BigDecimal
    # field :name, type: BigDecimal
    # field :startPrice, type: BigDecimal
    # field :highestPrice, type: BigDecimal
    # field :lowestPrice, type: BigDecimal
    # field :yesClose, type: BigDecimal
    # field :todayClose, type: BigDecimal
    # field :dealPrice, type: BigDecimal
    # field :dealDelta, type: BigDecimal

    def initialize(range, number, name, startPrice, highestPrice, lowestPrice, yesClose, todayClose, dealPrice, dealDelta)
      @range = range
      @number = number
      @name = name
      @startPrice = startPrice
      @highestPrice = highestPrice
      @lowestPrice = lowestPrice
      @yesClose = yesClose
      @todayClose = todayClose
      @dealPrice = dealPrice
      @dealDelta = dealDelta
    end

    def mongoize
      {
        :range => @range,
        :number => @number,
        :name => @name,
        :startPrice => @startPrice,
        :highestPrice => @highestPrice,
        :lowestPrice => @lowestPrice,
        :yesClose => @yesClose,
        :todayClose => @todayClose,
        :dealPrice => @dealPrice,
        :dealDelta => @dealDelta
      }
    end

    class << self
      def demongoize(object)
        Turnover.new(object["range"], object["number"], object["name"], object["startPrice"], object["highestPrice"], object["lowestPrice"], object["yesClose"], object["todayClose"], object["dealPrice"], object["dealDelta"])
      end

      def mongoize(object)
        case object
        when Turnover then object.mongoize
        else object
        end
      end
    end
  end
end
