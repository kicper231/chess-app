import 'package:chessproject/bussines/Game_managment/game_managment_bloc.dart';
import 'package:chessproject/datalayer/models/board.dart';
import 'package:chessproject/presentation/square.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChessBoardWidget extends StatelessWidget {
  ChessBoardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemCount: 64,
        itemBuilder: (context, index) {
          return BlocBuilder<GameManagmentBloc, GameManagmentState>(
            builder: (context, state) {
              return SquareWidget(
                square: context
                    .read<GameManagmentBloc>()!
                    .chessGame
                    .board!
                    .board[index],
                index: index,
              );
            },
          );
        },
      ),
    );
  }
}
