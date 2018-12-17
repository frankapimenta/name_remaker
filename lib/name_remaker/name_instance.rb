module NameRemaker
  class NameInstance
    attr_reader :first_names, :last_names

    def initialize first_names: nil, last_names: nil, &block
      set_first_names first_names
      set_last_names last_names

      @name_combination = NameCombination.new self
    end

    def names
      [*@first_names, *@last_names].dup.freeze
    end

    def first_name
      @first_names.first.dup.freeze
    end

    def last_name
      @last_names.last.dup.freeze
    end

    def full_name(separator: ' ', reversed: false)
      _first_names = @first_names.dup.join(' ')
      _last_names  = @last_names.dup.join(' ')

      return [_last_names, _first_names].join(separator).freeze if reversed

      [_first_names, _last_names].join(separator).freeze
    end

    def first_and_last_name(separator: ' ', reversed: false)
      return last_and_first_name(separator: separator) if reversed

      [first_name, last_name].join(separator).freeze
    end

    def last_and_first_name(separator: ' ', reversed: false)
      return first_and_last_name(separator: separator).freeze if reversed

      [last_name, first_name].join(separator).freeze
    end

    def middle_names
      [*@first_names[1..-1].dup, *@last_names.dup].freeze
    end

    def longer_than max_length:
      full_name.length > max_length
    end

    def combinations
      @name_combination.all
    end

    private

      def set_info **args
        arguments = *args

        keys, values = args.map(&:first), args.map(&:last)
        unless values.inject([]) { |res, val| res << val.class}.all? { |klass| klass == String || klass == Array }
          raise ArgumentError.new("first names must be given as a String or Array")
        end

        arguments.each do |key, value|
          instance_variable_set "@#{key}", value.freeze
        end
      end

      def set_first_names first_names
        if first_names.is_a?(String)
          @first_names = first_names.split(' ')
        elsif first_names.is_a?(Array)
          @first_names = first_names
        else
          raise ArgumentError.new("first names must be given as a String or Array")
        end
        @first_names.freeze
      end

      def set_last_names last_names
        if last_names.is_a?(String)
          @last_names = last_names.split(' ')
        elsif last_names.is_a?(Array)
          @last_names = last_names
        else
          raise ArgumentError.new("last names must be given as a String or Array")
        end
        @last_names.freeze
      end
  end
end

