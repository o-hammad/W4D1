class PolyTreeNode
    attr_reader :value, :parent, :children
    
    def initialize(value)
        @value = value
        @parent = nil
        @children = Array.new
    end

    def parent=(parent_node)
        old_parent = self.parent
        old_parent.children.delete(self) if old_parent != nil
        parent_node == nil ? @parent = nil : @parent = parent_node
        if parent_node != nil
            if !parent_node.children.include?(self)
                parent_node.children << self
            end
        end
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        raise if !self.children.include?(child)
        child.parent = nil
    end

    def dfs(target)
        return nil if self == nil
        return self if self.value == target
        
        self.children.each do |child|
            search_result = child.dfs(target)
            return search_result unless search_result == nil
        end

        nil
    end

    def bfs(target)
        queue = [self]

        until queue.empty?
            el = queue.shift
            return el if el.value == target
            el.children.each { |child| queue << child }
        end

        nil
    end
end