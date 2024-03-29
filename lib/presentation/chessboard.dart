import 'package:chessproject/bussines/Game_managment/game_managment_bloc.dart';
import 'package:chessproject/bussines/move_figure/move_figure_bloc.dart';

import 'package:chessproject/datalayer/models/figures.dart';
import 'package:chessproject/datalayer/models/square.dart';
import 'package:chessproject/presentation/square.dart';
import 'package:flutter/material.dart';

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
  bool isfirstxd = false;
  bool isCheckMate = false;
  bool isCheck = false;
  bool isWhiteMove = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    double widthscreen = MediaQuery.of(context).size.width;
    double heightscreen = MediaQuery.of(context).size.height;

    return BlocListener<GameManagmentBloc, GameManagmentState>(
      listener: (context, state) {},
      child: BlocListener<MoveFigureBloc, MoveFigureState>(
        listener: (context, state) {
          if (state is EndMoving) {
            setState(() {
              if (isWhiteMove) {
                // _stopWatchTimerWhite!.onStopTimer();
              } else {
                //_stopWatchTimerWhite!.onStartTimer();
              }
              if (state.figure != null) {
                if (state.figure!.isWhite) {
                  whitetaken.add(state.figure);
                } else {
                  blacktaken.add(state.figure);
                }
              }
              isCheck = state.isCheck;
              isCheckMate = state.isCheckmate;
              isWhiteMove = state.isWhiteTurn;
              if (state.isCheckmate == true) {
                context.read<GameManagmentBloc>().add(GameEnd());
                setState(() {
                  whitetaken = [];
                  blacktaken = [];
                  isWhiteMove = true;
                  isCheck = false;
                  isCheckMate = false;
                });
              }
            });
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: heightscreen * 0.1,
              width: widthscreen,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      //border: Border.all(width: 1),
                      color: Color.fromARGB(255, 43, 41, 38),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 5, left: 30, right: 5, bottom: 5),
                      child: Text('5:00',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color.fromARGB(255, 130, 127, 129))),
                    ),
                    // color: Colors.blue,
                  ),
                ],
              ),
            ),
            Container(
              //  color: Color.fromARGB(255, 252, 113, 8),
              height: widthscreen / 16,
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
              //    color: Colors.amber,
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
              //      color: Color.fromARGB(255, 255, 77, 0),
              height: widthscreen / 16,
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
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      //border: Border.all(width: 1),
                      color: Color.fromARGB(255, 43, 41, 38),
                    ),
                    // child: Padding(
                    //   padding: EdgeInsets.only(
                    //       top: 5, left: 30, right: 5, bottom: 5),
                    //   child: StreamBuilder<int?>(
                    //       stream: _stopWatchTimerWhite!.rawTime,
                    //       initialData: 0,
                    //       builder: (context, snapshot) {
                    //         final value = snapshot.data;
                    //         final displayTime =
                    //             StopWatchTimer.getDisplayTimeMinute(value!);
                    //         final displayseconds =
                    //             StopWatchTimer.getDisplayTimeSecond(value);

                    //         if (isfirstxd &&
                    //             displayseconds == '00' &&
                    //             displayTime == '00') {
                    //           context
                    //               .read<GameManagmentBloc>()
                    //               .add(WhiteTimeOut());
                    //         } else {
                    //           isfirstxd = true;
                    //         }
                    //         return Text('$displayTime:$displayseconds',
                    //             style: const TextStyle(
                    //                 fontWeight: FontWeight.bold,
                    //                 fontSize: 25,
                    //                 color: Color.fromARGB(255, 130, 127, 129)));
                    //       }),
                    // ),
                    // // color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> endGame(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title:
                isWhiteMove ? const Text("BLACK WIN") : const Text("WHITE WIN"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    isCheck = false;
                    isCheckMate = false;
                    whitetaken = [];
                    blacktaken = [];
                  });
                  context.read<GameManagmentBloc>().add(GameInitEvent());
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                    ),
                    // color: Colors.black),
                    child: const Text("Next Game?")),
              ),
            ],
          );
        });
  }
}
