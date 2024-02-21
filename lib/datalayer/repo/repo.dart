import 'package:chessproject/datalayer/models/board.dart';
import 'package:chessproject/datalayer/models/square.dart';

class Game {
  ChessBoard? board;
  Square? choosenSquare;
  //ChessBoard chessBoard;
  //final Player player1;
  // final Player player2;
  //final List<String> movesHistory;

  Game() {
    board = ChessBoard();
  }
}
