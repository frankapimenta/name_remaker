module NameRemaker
  class NameCombination

    def initialize name_instance
      @name_instance = name_instance
    end

    def first_names
      @name_instance.first_names
    end

    def last_names
      @name_instance.last_names
    end

    def first_name
      @name_instance.first_name
    end

    def middle_names
      @name_instance.middle_names
    end

    def all
      full_name_combinations
    end

    private

      def build_full_name_combination middle_name_combination
        _middle_names = middle_name_combination.split(' ')

        _last_names   = _middle_names.select {|name| last_names.include? name }
        return if _last_names.none?

        _first_names  = [first_name]
        _first_names += _middle_names.select {|name| first_names.include? name }

        NameInstance.new first_names: _first_names, last_names: _last_names
      end

      def full_name_combinations
        middle_names_combinations.map do |combination|
          build_full_name_combination combination
        end.compact
      end

      def middle_names_combinations# in order
        combinations  = []
        middles       = middle_names
        middles_count = middles.size
        middles_count.downto(0).map do |combination|
          combinations << middles.combination(combination).map do |names|
            names.join(' ')
          end
        end

        combinations.flatten.reject(&:empty?)
      end
  end
end
