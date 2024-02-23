import 'package:chessproject/bussines/Game_managment/game_managment_bloc.dart';
import 'package:chessproject/bussines/move_figure/move_figure_bloc.dart';
import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/models/square.dart';
import 'package:chessproject/datalayer/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquareWidget extends StatelessWidget {
  Square? square;
  int index;
  bool isCheck;
  SquareWidget(
      {super.key,
      required this.square,
      required this.index,
      required this.isCheck});
  Color? squareColor;

  @override
  Widget build(BuildContext context) {
    if (square != null) {
      squareColor = square!.isWhite
          ? Color.fromARGB(255, 201, 202, 202)
          : Color.fromARGB(255, 138, 139, 140);

      if (square!.isChoose) {
        squareColor =
            squareColor!.withBlue((squareColor!.blue - 30).clamp(0, 255));
      }
    }

    return BlocBuilder<MoveFigureBloc, MoveFigureState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (square?.figure != null &&
                state.isWhiteTurn == square?.figure!.isWhite) {
              context.read<MoveFigureBloc>().add(
                  TapOnFigure(pieceIndex: index, tapPiece: square!.figure));
            }
            if (square!.isValid == true) {
              if (square!.figure != null &&
                  state.isWhiteTurn != square?.figure!.isWhite) {
                context
                    .read<MoveFigureBloc>()
                    .add(CaptureFigure(moveIndex: index));
              } else {
                context
                    .read<MoveFigureBloc>()
                    .add(TapOnValidMove(moveIndex: index));
              }
            }
            context.read<GameManagmentBloc>().add(GameOnGoing());
          },
          child: Container(
            color: squareColor,
            child: square?.figure != null
                ? Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: !square!.isValid
                        ? Stack(
                            children: [
                              Image.asset(
                                square!.figure!.image,
                                color: square!.figure!.isWhite
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              if (square!.figure != null &&
                                  square!.figure!.type == PieceType.King &&
                                  isCheck)
                                Opacity(
                                  opacity: 0.4,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3,
                                              color: Color.fromARGB(
                                                  255, 255, 82, 82)),
                                          //color: Colors.red,
                                          shape: BoxShape.circle)),
                                ),
                            ],
                          )
                        : Stack(children: [
                            Image.asset(
                              square!.figure!.image,
                              color: square!.figure!.isWhite
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            Opacity(
                              opacity: 0.4,
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                      //color: Colors.red,
                                      shape: BoxShape.circle)),
                            ),
                          ]),
                  )
                : square!.isValid
                    ? Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.3)),
                        ))
                    : null,
          ),
        );
      },
    );
  }
}
