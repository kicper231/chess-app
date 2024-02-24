import 'package:chessproject/datalayer/models/board.dart';

import 'package:chessproject/datalayer/models/square.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Game {
  ChessBoard? board;
  Square? choosenSquare;
  bool isWhiteMove = true;
  int whiteKing;
  int blackKing;
  bool isCheck = false;
  late StopWatchTimer whiteTimer;
  late StopWatchTimer blackTimer;
  late int length;

  Game({
    required this.isWhiteMove,
    required this.whiteKing,
    required this.blackKing,
  }) {
    board = ChessBoard();
  }

  void start(int length) {
    board = ChessBoard();
    choosenSquare = null;
    isWhiteMove = true;
    isCheck = false;
    this.length = length;

    blackTimer = whiteTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      presetMillisecond: StopWatchTimer.getMilliSecFromSecond(length),
    );
  }
}
