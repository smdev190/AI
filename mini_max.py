def minimax(position, depth, is_maximizing_player, evaluate, get_children, is_terminal):
    if depth == 0 or is_terminal(position):
        return evaluate(position)

    if is_maximizing_player:
        max_eval = float('-inf')
        for child in get_children(position, True):
            eval = minimax(child, depth - 1, False, evaluate, get_children, is_terminal)
            max_eval = max(max_eval, eval)
        return max_eval
    else:
        min_eval = float('inf')
        for child in get_children(position, False):
            eval = minimax(child, depth - 1, True, evaluate, get_children, is_terminal)
            min_eval = min(min_eval, eval)
        return min_eval
