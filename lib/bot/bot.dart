class Bot {
  int play(List<String> board) {
    return _getBestMove(board, "o").index;
  }

  int _getBestScore(List<String> board, String player) {
    String evaluation = _evaluate(board, player);

    if (evaluation == player) {
      return 100;
    } else if (evaluation == "draw") {
      return 0;
    } else if (evaluation == flip(player)) {
      return -100;
    }

    return _getBestMove(board, player).score;
  }

  Move _getBestMove(List<String> board, player) {
    List<String> newBoard;
    int bestScore = -10000;
    int bestMove = -1;
    for (int currentMove = 0; currentMove < 9; currentMove++) {
      if (board[currentMove] == "") {
        newBoard = List.from(board);
        newBoard[currentMove] = player;

        int nextScore = -_getBestScore(newBoard, flip(player));
        if (nextScore >= bestScore) {
          bestScore = nextScore;
          bestMove = currentMove;
        }
      }
    }
    Move move = new Move(score: bestScore, index: bestMove);
    return move;
  }

  String flip(String player) {
    if (player == "x") {
      return "o";
    } else {
      return "x";
    }
  }

  String _evaluate(_matrix, player) {
    //check for win
    if ((_matrix[0] == player &&
            _matrix[1] == player &&
            _matrix[2] == player) ||
        (_matrix[3] == player &&
            _matrix[4] == player &&
            _matrix[5] == player) ||
        (_matrix[6] == player &&
            _matrix[7] == player &&
            _matrix[8] == player) ||
        (_matrix[0] == player &&
            _matrix[3] == player &&
            _matrix[6] == player) ||
        (_matrix[1] == player &&
            _matrix[4] == player &&
            _matrix[7] == player) ||
        (_matrix[2] == player &&
            _matrix[5] == player &&
            _matrix[8] == player) ||
        (_matrix[0] == player &&
            _matrix[4] == player &&
            _matrix[8] == player) ||
        (_matrix[2] == player &&
            _matrix[4] == player &&
            _matrix[6] == player)) {
      return player;
    }
    //check for loose
    player = flip(player);
    if ((_matrix[0] == player &&
            _matrix[1] == player &&
            _matrix[2] == player) ||
        (_matrix[3] == player &&
            _matrix[4] == player &&
            _matrix[5] == player) ||
        (_matrix[6] == player &&
            _matrix[7] == player &&
            _matrix[8] == player) ||
        (_matrix[0] == player &&
            _matrix[3] == player &&
            _matrix[6] == player) ||
        (_matrix[1] == player &&
            _matrix[4] == player &&
            _matrix[7] == player) ||
        (_matrix[2] == player &&
            _matrix[5] == player &&
            _matrix[8] == player) ||
        (_matrix[0] == player &&
            _matrix[4] == player &&
            _matrix[8] == player) ||
        (_matrix[2] == player &&
            _matrix[4] == player &&
            _matrix[6] == player)) {
      return player;
    }
    for (int i = 0; i < 9; i++) {
      if (_matrix[i] == "") {
        return "not yet"; //still moves are available
      }
    }
    return "draw"; //no moves available
  }
}

///a simple struct to return both score and index of the move
class Move {
  int score;
  int index;

  Move({this.score, this.index});
}
