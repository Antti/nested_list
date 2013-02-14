require 'tree'
module NestedSelect
  class Tree
    attr_reader :root_node
    def initialize
      @root_node = ::Tree::TreeNode.new("root")
    end

    def add_item(item)
      if item.level == 0
        root_node << ::Tree::TreeNode.new(item.name, item)
        return
      end
      node = root_node
      levels = []
      item.levels.each.with_index do |level_name, level|
        level_name = "unknown category" if level_name.blank? #Empty level_name causing error in  NestedSelect::Item#level method.
        levels << level_name
        if node[level_name]
          node[level_name].content = item if node[level_name].content.virtual? && level == item.level
        else
          if level == item.level
            node << ::Tree::TreeNode.new(level_name,item)
          else
            node << ::Tree::TreeNode.new(level_name,Item.new(levels.join(Item::SEPARATOR)))
          end
        end
        node = node[level_name]
      end
    end

    def html
      @content = ''
      html_for_node root_node
      @content
    end

    protected
    def html_for_node(node)
      node.children do |child|
        @content += child.content.html
        html_for_node(child)
      end
    end
  end
end
