import 'package:chessproject/bussines/Game_managment/game_managment_bloc.dart';
import 'package:chessproject/bussines/move_figure/move_figure_bloc.dart';
import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/models/square.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquareWidget extends StatefulWidget {
  final Square? square;
  final int index;
  final bool isCheck;

  SquareWidget(
      {super.key,
      required this.square,
      required this.index,
      required this.isCheck});

  @override
  State<SquareWidget> createState() => _SquareWidgetState();
}

class _SquareWidgetState extends State<SquareWidget> {
  late double titleWidth = MediaQuery.of(context).size.width / 8;

  late double titleHeight = MediaQuery.of(context).size.height / 8;
  late bool isWHiteTurn = true;

  Color? squareColor;

  @override
  Widget build(BuildContext context) {
    if (widget.square != null) {
      squareColor = widget.square!.isWhite
          ? Color.fromARGB(255, 201, 202, 202)
          : Color.fromARGB(255, 138, 139, 140);

      if (widget.square!.isChoose) {
        squareColor =
            squareColor!.withBlue((squareColor!.blue - 30).clamp(0, 255));
      }
    }

    return MultiBlocListener(
      listeners: [
        BlocListener<GameManagmentBloc, GameManagmentState>(
            listener: (context, state) {
          if (state is GameManagmentEnd) {
            setState(() {
              isWHiteTurn = true;
            });
          }
        }),
        BlocListener<MoveFigureBloc, MoveFigureState>(
          listener: (context, state) {
            setState(() {
              isWHiteTurn = state.isWhiteTurn;
            });
          },
        ),
      ],
      child: GestureDetector(
        onLongPress: () {
          onTapAction(context);
        },
        onTapDown: (TapDownDetails) {
          onTapAction(context);
        },
        child: widget.square!.figure != null &&
                widget.square!.figure!.isWhite == isWHiteTurn
            ? Draggable<ChessPiece>(
                onDragStarted: () {
                  onTapAction(context);
                },
                feedback: chessImage(),
                data: widget.square!.figure,
                childWhenDragging: Container(
                  color: squareColor,
                ),
                child: squareLook(),
              )
            : squareLook(),
      ),
    );
  }

  void onTapAction(BuildContext context) {
    if (widget.square?.figure != null &&
        isWHiteTurn == widget.square?.figure!.isWhite) {
      context.read<MoveFigureBloc>().add(TapOnFigure(
          pieceIndex: widget.index, tapPiece: widget.square!.figure));
    }
    if (widget.square!.isValid == true) {
      if (widget.square!.figure != null &&
          isWHiteTurn != widget.square?.figure!.isWhite) {
        context
            .read<MoveFigureBloc>()
            .add(CaptureFigure(moveIndex: widget.index));
      } else {
        context
            .read<MoveFigureBloc>()
            .add(TapOnValidMove(moveIndex: widget.index));
      }
    }

    context.read<GameManagmentBloc>().add(GameOnGoing());
  }

  Image chessImage() {
    return Image.asset(
      widget.square!.figure!.image,
      color: widget.square!.figure!.isWhite ? Colors.white : Colors.black,
      width: titleWidth,
      height: titleHeight,
    );
  }

  Container squareLook() {
    return Container(
      color: squareColor,
      child: widget.square?.figure != null
          ? Padding(
              padding: const EdgeInsets.all(1.0),
              child: !widget.square!.isValid
                  ? Stack(
                      children: [
                        chessImage(),
                        if (widget.square!.figure != null &&
                            widget.square!.figure!.type == PieceType.King &&
                            widget.square!.figure!.isWhite == isWHiteTurn &&
                            widget.isCheck)
                          Opacity(
                            opacity: 0.4,
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 3,
                                        color:
                                            Color.fromARGB(255, 255, 82, 82)),
                                    //color: Colors.red,
                                    shape: BoxShape.circle)),
                          ),
                      ],
                    )
                  : DragTarget<ChessPiece>(
                      onAccept: (data) {},
                      builder: (context, data, rejects) => Stack(children: [
                        chessImage(),
                        Opacity(
                          opacity: 0.4,
                          child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 3,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                  //color: Colors.red,
                                  shape: BoxShape.circle)),
                        ),
                      ]),
                    ),
            )
          : widget.square!.isValid
              ? DragTarget<ChessPiece>(
                  onAccept: (data) {
                    onTapAction(context);
                  },
                  onWillAccept: (details) {
                    return true;
                  },
                  builder: (context, candidateData, rejectedData) => Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3)),
                      )),
                )
              : null,
    );
  }
}
