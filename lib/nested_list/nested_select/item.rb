module NestedSelect
  class Item
    SPACE_SEQUENCE = '&nbsp;&nbsp;&nbsp;&nbsp;'
    SEPARATOR = ">"
    attr_accessor :name, :parent, :id

    def initialize(name, id=nil)
      @name = name.to_s.strip
      @id = id
    end

    def parameterized_name(names)
      names.map { |name| name.to_s.strip.downcase }.join("-")
    end

    def levels
      @name.split(SEPARATOR)
    end

    def virtual?
      !id
    end

    def level
      levels.size - 1
    end

    def value
      if virtual?
        "#{parameterized_name(levels)}:group"
      else
        id
      end
    end

    def html
      klass = virtual? ? "group" : "item"
      "<option value='#{self.value}' class='level_#{level} #{klass}'>#{spaces}#{html_content.humanize}</option>"
    end

    protected

    def html_content
      levels.last
    end

    def spaces
      SPACE_SEQUENCE * level
    end

  end
end