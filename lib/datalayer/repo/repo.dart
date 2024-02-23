import 'package:chessproject/datalayer/models/board.dart';
import 'package:chessproject/datalayer/models/square.dart';

class Game {
  ChessBoard? board;
  Square? choosenSquare;
  bool isWhiteMove = true;
  int whiteKing;
  int blackKing;
  bool isCheck = false;

  //ChessBoard chessBoard;
  //final Player player1;
  // final Player player2;
  //final List<String> movesHistory;

  Game(
      {required this.isWhiteMove,
      required this.whiteKing,
      required this.blackKing}) {
    board = ChessBoard();
  }

  void start() {
    board = ChessBoard();
    choosenSquare = null;
    isWhiteMove = true;
    isCheck = false;
  }
}
