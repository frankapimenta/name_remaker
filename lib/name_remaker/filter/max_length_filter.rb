module NameRemaker
  class MaxLengthFilter < Filter

    attr_reader :max_length

    def initialize collection, max_length
      raise ArgumentError.new "block is not accepted" if block_given?

      super(collection, &condition)

      @max_length = max_length
    end

    def condition
      ->(item) { item.full_name.length <= max_length }
    end
  end
end
