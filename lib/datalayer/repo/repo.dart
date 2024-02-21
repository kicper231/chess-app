import 'package:chessproject/datalayer/models/board.dart';
import 'package:chessproject/datalayer/models/square.dart';

class Game {
  ChessBoard? board;
  Square? choosenSquare;
  bool isWhiteMove = true;

  //ChessBoard chessBoard;
  //final Player player1;
  // final Player player2;
  //final List<String> movesHistory;

  Game({required this.isWhiteMove}) {
    board = ChessBoard();
  }
}
