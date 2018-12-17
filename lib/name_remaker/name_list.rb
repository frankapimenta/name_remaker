module NameRemaker
  class NameList
    include Enumerable

    def initialize name_instance
      @name_instance = name_instance
    end

    def all
      @name_instance.combinations
    end

    def each(&block)
      all.each(&block)
    end

    def max_length_of max_length
      filtered_names_list = MaxLengthFilter.new(all, max_length).filtered
      filtered_names_list.sort { |a,b| b.full_name.length <=> a.full_name.length }
    end

  end
end
