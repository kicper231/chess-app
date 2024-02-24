import 'package:chessproject/bussines/Game_managment/game_managment_bloc.dart';
import 'package:chessproject/presentation/chessboard.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    late int length;
    return BlocListener<GameManagmentBloc, GameManagmentState>(
      listener: (context, state) {
        if (state is GameManagmentSettings) {
          startGameDialog(context);
        }

        if (state is GameManagmentEnd) {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: state.isWhiteTurn
                      ? const Text("BLACK WIN")
                      : const Text("WHITE WIN"),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<GameManagmentBloc>().add(GameInitEvent());
                      },
                      child: Container(

                          // color: Colors.black),
                          child: const Text("Next Game?")),
                    ),
                  ],
                );
              });
        }
      },
      child: Scaffold(
        body: ChessBoardWidget(),
        backgroundColor: const Color.fromARGB(255, 56, 54, 50),
      ),
    );
  }

  void startGameDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Wybierz Rodzaj Gry:'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  context
                      .read<GameManagmentBloc>()
                      .add(GameStartEvent(length: 60 * 5));
                },
                child: const Text('5 min'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  context
                      .read<GameManagmentBloc>()
                      .add(GameStartEvent(length: 60 * 15));
                },
                child: const Text('15 min'),
              ),
            ],
          );
        });
  }
}
