class Dominoes
  def self.chain?(dominoes)
    return true if dominoes.empty?
    degree = Hash.new(0)
    graph = Hash.new { |h, k| h[k] = [] }
    dominoes.each do |a, b|
      degree[a] += 1
      degree[b] += 1
      graph[a] << b
      graph[b] << a
    end
    return false unless degree.values.all?(&:even?)
    start = degree.keys.first
    visited = Set.new
    stack = [start]
    until stack.empty?
      v = stack.pop
      next if visited.include?(v)
      visited.add(v)
      graph[v].each { |nb| stack << nb unless visited.include?(nb) }
    end
    degree.keys.all? { |v| visited.include?(v) }
  end
end

require 'set'
