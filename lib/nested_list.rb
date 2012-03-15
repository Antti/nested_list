# encoding: utf-8
$:.push File.expand_path("../", __FILE__)
require "nested_list/nested_select/item"
require "nested_list/nested_select/tree"
require "active_support/inflector"

module Generator

  class NestedList
    # Get Array of nested names:
    #[{name: "All Categories", id: 'all'},
    # {name: "Audio", id: '1'},
    # {name: "Audio>Accessorize", id: '1424'},
    # {name: "Audio>Accessorize>Pillow", id: '45255'}
    # {name: "Audio>DVD", id: '234245'},
    # {name: "Baby", id: '44245tr5'}]
    def initialize(nested_names_arr)
      @nested_names_arr = nested_names_arr
      @tree = NestedSelect::Tree.new
      @nested_names_arr.each do |h|
        @tree.add_item(NestedSelect::Item.new(h[:name],h[:id]))
      end
    end

    #Return a list of nested html_options from nested names array
    def html_options
      @tree.html
    end
  end

  # Example
  def nested_options_example
    @nested_names_arr = []
    @nested_names_arr << {name: "All Categories", id: 'all'}
    @nested_names_arr << {name: "Audio>Accessorize>Smile", id: '566767'}
    @nested_names_arr << {name: "Audio>Accessorize>Pillow", id: '45255'}
    @nested_names_arr << {name: "Audio>DVD", id: '234245'}
    @nested_names_arr << {name: "Baby", id: '44245tr5'}

    nested_list = NestedList.new(@nested_names_arr)
    nested_list.html_options
  end

  #Support other languages
  # Example
  def nested_options_example_ru
    @nested_names_arr = []
    @nested_names_arr << {name: "Все категории", id: 'all'}
    @nested_names_arr << {name: "Аудио>Аксессуары>Smile", id: '566767'}
    @nested_names_arr << {name: "Аудио>Аксессуары>Подушка", id: '45255'}
    @nested_names_arr << {name: "Аудио>DVD", id: '234245'}
    @nested_names_arr << {name: "Товары для детей", id: '44245tr5'}

    nested_list = NestedList.new(@nested_names_arr)
    nested_list.html_options
  end

end