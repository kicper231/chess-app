import 'package:bloc/bloc.dart';
import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/repo/repo.dart';
import 'package:equatable/equatable.dart';

part 'move_figure_event.dart';
part 'move_figure_state.dart';

class MoveFigureBloc extends Bloc<MoveFigureEvent, MoveFigureState> {
  Game chessGame;

  MoveFigureBloc({required this.chessGame})
      : super(MoveFigureInitial(isWhiteTurn: true)) {
    on<TapOnFigure>((event, emit) {
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
      });
      if (chessGame.choosenSquare != null) {
        chessGame.choosenSquare!.isChoose = false;
      }
      chessGame.board?.validMoves(event.pieceIndex);
      chessGame.choosenSquare = chessGame.board!.board[event.pieceIndex];

      chessGame.board!.board[event.pieceIndex]!.isChoose = true;
      emit(StartMoving(isWhiteTurn: chessGame.isWhiteMove));
    });

    on<TapOnValidMove>((event, emit) {
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
      });
      if (chessGame.choosenSquare != null) {
        chessGame.choosenSquare!.isChoose = false;
      }
      chessGame.board!.board[event.moveIndex]!.figure =
          chessGame.choosenSquare!.figure;
      chessGame.choosenSquare!.figure = null;
      chessGame.isWhiteMove = !chessGame.isWhiteMove;
      emit(EndMoving(isWhiteTurn: chessGame.isWhiteMove));
    });

    on<CaptureFigure>((event, emit) {
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
      });

      chessGame.board!.board[event.moveIndex]!.figure =
          chessGame.choosenSquare!.figure;

      if (chessGame.choosenSquare != null) {
        chessGame.choosenSquare!.isChoose = false;
      }

      chessGame.choosenSquare!.figure = null;
      chessGame.board!.board[event.moveIndex]!.isChoose = false;
      chessGame.isWhiteMove = !chessGame.isWhiteMove;
      //zerestowanie choosen sqaure podrkeslonego
      // chessGame.choosenSquare = null;
      // zresetowania valid moves

      emit(EndMoving(isWhiteTurn: chessGame.isWhiteMove));
    });
  }
}
