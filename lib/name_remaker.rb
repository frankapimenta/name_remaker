require "name_remaker/version"
require "name_remaker/name_combination"
require "name_remaker/name_instance"
require "name_remaker/filter"
require "name_remaker/filter/max_length_filter"
require "name_remaker/remake"
require "name_remaker/name_list"

module NameRemaker
  DEFAULT_FIRST_NAMES = "Tom Mark Antonio"
  DEFAULT_LAST_NAMES  = "Smith Grant Cruise"

  def remake first_names:, last_names:, **args
    Remake.new first_names: first_names, last_names: last_names
  end
  module_function :remake
end
