module NameRemaker
  class Filter
    attr_reader :collection, :condition

    def initialize collection, &condition
      @collection = collection
      @condition  = condition
    end

    def filtered
      raise NotImplementedError unless condition

      collection.select { |item| condition.call(item) }
    end

    def unfiltered
      raise NotImplementedError unless condition

      collection.select { |item| !condition.call(item) }
    end
  end
end
