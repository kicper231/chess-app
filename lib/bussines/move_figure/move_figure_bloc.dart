import 'package:bloc/bloc.dart';
import 'package:chessproject/datalayer/models/board.dart';
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
      chessGame.board
          ?.validMoves(event.pieceIndex, false, chessGame.isWhiteMove);
      chessGame.choosenSquare = chessGame.board!.board[event.pieceIndex];

      chessGame.board!.board[event.pieceIndex]!.isChoose = true;
      emit(StartMoving(isWhiteTurn: chessGame.isWhiteMove));
    });

    on<TapOnValidMove>((event, emit) {
      //zresetowanie wszystkich valid ruchow (raczej powinno byc w logice valid)
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
      });
      if (chessGame.choosenSquare != null) {
        chessGame.choosenSquare!.isChoose = false;
      }
      // zmiana tury i przypisanie figury do pola wybranego
      chessGame.board!.board[event.moveIndex]!.figure =
          chessGame.choosenSquare!.figure;
      chessGame.choosenSquare!.figure = null;
      chessGame.isWhiteMove = !chessGame.isWhiteMove;

      //emitowanie stanu
      emit(EndMoving(
          isWhiteTurn: chessGame.isWhiteMove,
          isCheck: chessGame.board!.kingCheck(chessGame.isWhiteMove),
          isCheckmate: chessGame.board!.isCheckMate(chessGame.isWhiteMove)));
    });

    on<CaptureFigure>((event, emit) {
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
      });
      ChessPiece? deadfigure;
      if (chessGame.board!.board[event.moveIndex]?.figure != null) {
        deadfigure = ChessPiece(
            type: chessGame.board!.board[event.moveIndex]!.figure!.type,
            isWhite: chessGame.board!.board[event.moveIndex]!.figure!.isWhite);
      }
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

      emit(
        EndMoving(
            isWhiteTurn: chessGame.isWhiteMove,
            figure: deadfigure,
            isCheck: chessGame.board!.kingCheck(chessGame.isWhiteMove),
            isCheckmate: chessGame.board!.isCheckMate(chessGame.isWhiteMove)),
      );
    });

    on<ResetMoves>(
      (event, emit) {
        //chessGame.start();
        emit(StartMoving(isWhiteTurn: chessGame.isWhiteMove));
      },
    );
  }
}
