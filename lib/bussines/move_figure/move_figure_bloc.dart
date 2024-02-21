import 'package:bloc/bloc.dart';
import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/repo/repo.dart';
import 'package:equatable/equatable.dart';

part 'move_figure_event.dart';
part 'move_figure_state.dart';

class MoveFigureBloc extends Bloc<MoveFigureEvent, MoveFigureState> {
  Game chessGame;

  MoveFigureBloc({required this.chessGame}) : super(MoveFigureInitial()) {
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
      emit(StartMoving());
    });

    on<TapOnValidMove>((event, emit) {
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
      });

      chessGame.board!.board[event.moveIndex]!.figure =
          chessGame.choosenSquare!.figure;

      chessGame.choosenSquare!.figure = null;
    });
  }
}
