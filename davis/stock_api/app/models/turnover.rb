module Turnover
  class TurnoverPerDay
    include Mongoid::Document
    store_in collection: "TurnoverPerDay", database: "turnovers"
    field :day, type: DateTime
    field :turnovers, type: Array

    def initialize
      self.day = DateTime.new
      self.turnovers = Array.new
    end

    def addTrunover(trunover)
      self.turnovers.push(trunover)
    end

  end


  class Turnover
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
