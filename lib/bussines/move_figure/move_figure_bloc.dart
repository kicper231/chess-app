import 'package:bloc/bloc.dart';

import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/models/move.dart';
import 'package:chessproject/datalayer/repo/repo.dart';
import 'package:equatable/equatable.dart';

part 'move_figure_event.dart';
part 'move_figure_state.dart';

class MoveFigureBloc extends Bloc<MoveFigureEvent, MoveFigureState> {
  Game chessGame;

  MoveFigureBloc({required this.chessGame})
      : super(const MoveFigureInitial(isWhiteTurn: true)) {
    //tap figure
    on<TapOnFigure>((event, emit) {
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
        value.isEnPessant = false;
        value.isshortCastling = false;
        value.islongCasteling = false;
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
    // tap on vlaid move
    on<TapOnValidMove>((event, emit) {
      //zresetowanie wszystkich valid ruchow (raczej powinno byc w logice valid)
      if (chessGame.isWhiteMove) {
        chessGame.whiteTimer.onStopTimer();
      } else {
        chessGame.blackTimer.onStopTimer();
      }
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
      });
      if (chessGame.choosenSquare != null) {
        chessGame.choosenSquare!.isChoose = false;
      }

      // zmiana tury i przypisanie figury do pola wybranego
      chessGame.board!.board[event.moveIndex]!.figure = ChessPiece(
          type: chessGame.choosenSquare!.figure!.type,
          isWhite: chessGame.choosenSquare!.figure!.isWhite,
          isMoved: chessGame.choosenSquare!.figure!.isMoved);
      // chessGame.choosenSquare!.figure = null;
      chessGame.choosenSquare!.figure = null;
      chessGame.isWhiteMove = !chessGame.isWhiteMove;
      chessGame.board!.board[event.moveIndex]!.figure!.isMoved = true;

      //historia ruchów

      bool isEnPessant =
          chessGame.board!.board[event.moveIndex]!.figure!.type ==
                  PieceType.Pawn &&
              (event.moveIndex - chessGame.choosenSquare!.index).abs() > 8;
      //historia ruchów
      chessGame.board!.board[event.moveIndex]!.figure!.isMoved = true;
      chessGame.board!.moves.add(Move(
          typ: chessGame.board!.board[event.moveIndex]!.figure!.type,
          to: event.moveIndex,
          from: chessGame.choosenSquare!.index,
          isEnPessant: isEnPessant));
      chessGame.board!.lastmove = chessGame.board!.moves.last;

      //promocja
      if ((((event.moveIndex ~/ 8) == 0) || (event.moveIndex ~/ 8 == 7)) &&
          chessGame.board!.board[event.moveIndex]!.figure!.type ==
              PieceType.Pawn) {
        chessGame.board!.board[event.moveIndex]!.figure!.type = PieceType.Queen;
      }
      ChessPiece? deadfigure;
      // bicie w przelocie
      if (chessGame.board!.board[event.moveIndex]!.isEnPessant == true) {
        int direction = chessGame.isWhiteMove ? 1 : -1;
        deadfigure = ChessPiece(
            type: chessGame
                .board!.board[event.moveIndex - 8 * direction]!.figure!.type,
            isWhite: chessGame
                .board!.board[event.moveIndex - 8 * direction]!.figure!.isWhite,
            isMoved: chessGame.board!.board[event.moveIndex - 8 * direction]!
                        .figure?.isMoved !=
                    null
                ? chessGame.board!.board[event.moveIndex - 8 * direction]!
                    .figure!.isMoved
                : false);
        chessGame.board!.board[event.moveIndex]!.isEnPessant = false;
        chessGame.board!.board[event.moveIndex - 8 * direction]!.figure = null;
      }

      if (chessGame.board!.board[event.moveIndex]!.isshortCastling == true) {
        chessGame.board!.board[event.moveIndex - 1]!.figure =
            chessGame.board!.board[event.moveIndex + 1]!.figure;
        chessGame.board!.board[event.moveIndex + 1]!.figure = null;
      }

      if (chessGame.board!.board[event.moveIndex]!.islongCasteling == true) {
        chessGame.board!.board[event.moveIndex + 1]!.figure =
            chessGame.board!.board[event.moveIndex - 2]!.figure;
        chessGame.board!.board[event.moveIndex - 2]!.figure = null;
      }

      emit(EndMoving(
          figure: deadfigure,
          isWhiteTurn: chessGame.isWhiteMove,
          isCheck: chessGame.board!.kingCheck(chessGame.isWhiteMove),
          isCheckmate: chessGame.board!.isCheckMate(chessGame.isWhiteMove)));
    });

    on<CaptureFigure>((event, emit) {
      chessGame.board!.board.forEach((key, value) {
        value!.isValid = false;
        value.isEnPessant = false;
      });
      //figura zbita (martwa)
      ChessPiece? deadfigure;
      if (chessGame.board!.board[event.moveIndex]?.figure != null) {
        deadfigure = ChessPiece(
            type: chessGame.board!.board[event.moveIndex]!.figure!.type,
            isWhite: chessGame.board!.board[event.moveIndex]!.figure!.isWhite,
            isMoved: chessGame.board!.board[event.moveIndex]!.figure!.isMoved);
      }
      //przypisanie)
      chessGame.board!.board[event.moveIndex]!.figure =
          chessGame.choosenSquare!.figure;
      //zmienienie choosen
      if (chessGame.choosenSquare != null) {
        chessGame.choosenSquare!.isChoose = false;
      }
      //zamiana figur
      chessGame.choosenSquare!.figure = null;
      chessGame.board!.board[event.moveIndex]!.isChoose = false;
      chessGame.isWhiteMove = !chessGame.isWhiteMove;
      if ((((event.moveIndex ~/ 8) == 0) || (event.moveIndex ~/ 8 == 7)) &&
          chessGame.board!.board[event.moveIndex]!.figure!.type ==
              PieceType.Pawn) {
        chessGame.board!.board[event.moveIndex]!.figure!.type = PieceType.Queen;
      }
      // czy w przelocie
      bool isEnPessant =
          chessGame.board!.board[event.moveIndex]!.figure!.type ==
                  PieceType.Pawn &&
              (event.moveIndex - chessGame.choosenSquare!.index).abs() > 8;
      //historia ruchów
      chessGame.board!.board[event.moveIndex]!.figure!.isMoved = true;
      chessGame.board!.moves.add(Move(
          typ: chessGame.board!.board[event.moveIndex]!.figure!.type,
          to: event.moveIndex,
          from: chessGame.choosenSquare!.index,
          isEnPessant: isEnPessant));

      chessGame.board!.lastmove = chessGame.board!.moves.last;

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
