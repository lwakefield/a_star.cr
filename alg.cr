# from https://rosettacode.org/wiki/A*_search_algorithm#Python
class AStar(Position, AStarGraph)
        def self.a_star (start : Position, goal : Position, graph : AStarGraph)
                open_set = [start].to_set
                closed_set = Set(Position).new
                came_from = {} of Position => Position
                g_score = {} of Position => Int32
                f_score = {} of Position => Int32

                g_score[start] = 0
                f_score[start] = graph.heuristic(start, goal)

                until open_set.empty?
                        current = nil
                        current_f_score = nil
                        open_set.each do |v|
                                if current.nil? || f_score[v] < current_f_score.not_nil!
                                        current_f_score = f_score[v]
                                        current = v
                                end
                        end

                        if current == goal
                                path = [current.not_nil!]
                                while came_from[current]?
                                        current = came_from[current]
                                        path << current.not_nil!
                                end
                                return path.reverse
                        end

                        open_set.delete current
                        closed_set << current.not_nil!

                        graph.neighbors(current.not_nil!) do |n|
                                next if closed_set.includes? n

                                candidate_g = g_score[current] + graph.move_cost(current.not_nil!, n)

                                if !open_set.includes? n
                                        open_set << n
                                elsif candidate_g >= g_score[n]
                                        next
                                end

                                came_from[n] = current.not_nil!
                                g_score[n] = candidate_g
                                h = graph.heuristic(n, goal)
                                f_score[n] = g_score[n] + h
                        end
                end
                raise "could not find solution"
        end
end
