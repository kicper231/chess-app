import 'package:chessproject/bussines/Game_managment/game_managment_bloc.dart';
import 'package:chessproject/bussines/blocobserver.dart';
import 'package:chessproject/bussines/move_figure/move_figure_bloc.dart';
import 'package:chessproject/datalayer/repo/repo.dart';
import 'package:chessproject/presentation/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => Game(isWhiteMove: true, whiteKing: 60, blackKing: 4),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                GameManagmentBloc(chessGame: context.read<Game>()),
          ),
          BlocProvider(
            create: (context) =>
                MoveFigureBloc(chessGame: context.read<Game>()),
          ),
        ],
        child: const MaterialApp(
          //color: Color.fromARGB(255, 116, 37, 37),
          debugShowCheckedModeBanner: false,
          home: SizedBox(child: HomePage()),
        ),
      ),
    );
  }
}
