module NameRemaker
  class Remake
    include Enumerable

    def initialize first_names:, last_names:
      @name_instance = NameInstance.new first_names: first_names, last_names: last_names
    end

    def name_instance
      @name_instance
    end

    def full_name(separator: ' ', reversed: false)
      @name_instance.full_name(separator: separator, reversed: reversed)
    end

    def list
      NameList.new @name_instance
    end

    def all
      list.all
    end

    def each(&block)
      all.each(&block)
    end

    def inspect
      all
    end

    def print(separator: ' ', reversed: false)
      each {|combination| puts combination.full_name(separator: separator, reversed: reversed) }.to_enum
    end

    def max_length_of max_length
      list.max_length_of(max_length)
    end

    def full_name_longer_than max_length
      name_instance.longer_than max_length: max_length
    end

  end
end
