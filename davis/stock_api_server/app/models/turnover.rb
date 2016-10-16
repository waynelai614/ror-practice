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
