# a_star.cr

This is a simple implementation of the A* search algorithm implemented in Crystal.

The implementation is generic, requiring you pass a graph that parameter that implements `neighbors`, `move_cost` and `heuristic`. See `alg_spec.cr` for examples.
