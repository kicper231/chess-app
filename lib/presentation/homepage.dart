import 'package:chessproject/bussines/Game_managment/game_managment_bloc.dart';
import 'package:chessproject/presentation/chessboard.dart';
import 'package:bloc/bloc.dart';
import 'package:chessproject/presentation/chessboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameManagmentBloc, GameManagmentState>(
      listener: (context, state) {
        if (state is GameManagmentSettings) {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: const Text('Select assignment'),
                  children: <Widget>[
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<GameManagmentBloc>().add(GameStartEvent());
                      },
                      child: const Text('Treasury department'),
                    ),
                    SimpleDialogOption(
                      onPressed: () {
                        Navigator.pop(context);
                        context.read<GameManagmentBloc>().add(GameStartEvent());
                      },
                      child: const Text('State department'),
                    ),
                  ],
                );
              });
        }
      },
      child: Scaffold(
        body: ChessBoardWidget(),
        backgroundColor: Color.fromARGB(255, 120, 121, 122),
      ),
    );
  }
}
