require "spec"

require "./alg.cr"

alias Map = Array(Array(Char))
alias Vec2 = Tuple(Int32, Int32)

class Graph
        def initialize (@m : Map)
        end
        def heuristic (start : Vec2, goal : Vec2)
                dx = (start[0] - goal[0]).abs
                dy = (start[1] - goal[1]).abs
                dx + dy
        end
        def neighbors (p : Vec2)
                [{1,0}, {-1,0}, {0,1}, {0,-1}].each do |dx, dy|
                        x, y = p[0] + dx, p[1] + dy
                        next if x < 0 || x >= @m.first.size || y < 0 || y >= @m.size
                        yield({x, y})
                end

        end
        def move_cost (a : Vec2, b : Vec2)
                return 100 unless @m[b[1]][b[0]] == ' '
                1
        end
end

def s_to_map (s : String)
        s.split('\n').map(&.chars)
end

def map_to_s (m : Map)
        m.map(&.join).join('\n')
end

describe "a_star" do
        it "maps a path with no obstructions" do
                map = s_to_map "        \n" \
                               "        \n" \
                               "        \n" \
                               "        \n" \
                               "        \n" \
                               "        \n" \
                               "        \n" \
                               "        "

                path = AStar.a_star({0, 0}, {7, 7}, Graph.new(map))
                path.each do |p|
                        map[p[1]][p[0]] = '.'
                end

                map_to_s(map).should eq "........\n" \
                                        "       .\n" \
                                        "       .\n" \
                                        "       .\n" \
                                        "       .\n" \
                                        "       .\n" \
                                        "       .\n" \
                                        "       ."
        end

        it "maps a path with some obstructions" do
                map = s_to_map "        \n" \
                               "        \n" \
                               "   ###  \n" \
                               "   #    \n" \
                               "   # ###\n" \
                               "   # #  \n" \
                               "   # #  \n" \
                               "   #    "

                path = AStar.a_star({0, 0}, {7, 7}, Graph.new(map))
                path.each do |p|
                        map[p[1]][p[0]] = '.'
                end

                map_to_s(map).should eq "....... \n" \
                                        "      . \n" \
                                        "   ###. \n" \
                                        "   #... \n" \
                                        "   #.###\n" \
                                        "   #.#  \n" \
                                        "   #.#  \n" \
                                        "   #...."
        end
end
