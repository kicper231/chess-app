import 'package:chessproject/bussines/Game_managment/game_managment_bloc.dart';
import 'package:chessproject/bussines/move_figure/move_figure_bloc.dart';
import 'package:chessproject/datalayer/models/board.dart';
import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/models/square.dart';
import 'package:chessproject/presentation/square.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessBoardWidget extends StatefulWidget {
  ChessBoardWidget({super.key});

  @override
  State<ChessBoardWidget> createState() => _ChessBoardWidgetState();
}

class _ChessBoardWidgetState extends State<ChessBoardWidget> {
  @override
  List<ChessPiece?> whitetaken = [];
  List<ChessPiece?> blacktaken = [];
  bool isCheckMate = false;
  bool isCheck = false;
  Widget build(BuildContext context) {
    double widthscreen = MediaQuery.of(context).size.width;
    double heightscreen = MediaQuery.of(context).size.height;

    return BlocListener<MoveFigureBloc, MoveFigureState>(
      listener: (context, state) {
        if (state is EndMoving) {
          setState(() {
            if (state.figure != null) {
              if (state.figure!.isWhite) {
                whitetaken.add(state.figure);
              } else {
                blacktaken.add(state.figure);
              }
            }
            isCheck = state.isCheck;
            isCheckMate = state.isCheckmate;
            if (state.isCheckmate == true) {
              context.read<GameManagmentBloc>().add(GameEnd());
            }
          });
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: heightscreen * 0.2,
            width: widthscreen,
          ),
          Container(
            color: Color.fromARGB(255, 252, 113, 8),
            height: heightscreen * 0.05,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(top: 0, left: 0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 16,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemCount: whitetaken.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Image.asset(whitetaken[index]!.image,
                      color: whitetaken[index]!.isWhite
                          ? Colors.white
                          : Colors.black),
                );
              },
            ),
          ),
          Container(
            color: Colors.amber,
            child: GridView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 0, crossAxisSpacing: 0, crossAxisCount: 8),
              itemCount: 64,
              itemBuilder: (context, index) {
                return BlocBuilder<GameManagmentBloc, GameManagmentState>(
                    builder: (context, state) {
                  if (state is GameManagmentOnGoing) {
                    return SquareWidget(
                        square: state.chessGame.board!.board[index],
                        index: index,
                        isCheck: isCheck);
                  }

                  return SquareWidget(
                    square: Square(
                        figure: null,
                        isWhite: ((index ~/ 8) % 2 == 0)
                            ? index % 2 == 0
                            : index % 2 != 0,
                        isValid: false,
                        isChoose: false),
                    index: index,
                    isCheck: isCheck,
                  );
                });
              },
            ),
          ),
          Container(
            color: Color.fromARGB(255, 255, 77, 0),
            height: heightscreen * 0.05,
            padding: EdgeInsets.only(top: 0, left: 0),
            alignment: Alignment.topLeft,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(0.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 16,
                mainAxisSpacing: 0, // Zmniejsz odstęp wzdłuż głównej osi
                crossAxisSpacing: 0,

                // Zmniejsz odstęp wzdłuż poprzecznej osi
              ),
              itemCount: blacktaken.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  child: Image.asset(blacktaken[index]!.image,
                      color: blacktaken[index]!.isWhite
                          ? Colors.white
                          : Colors.black),
                );
              },
            ),
          ),
          isCheck ? Text("Check!") : Text("Check NO !"),
          if (isCheckMate) const Text("checkmate!"),
        ],
      ),
    );
  }
}
