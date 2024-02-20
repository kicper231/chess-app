import 'package:chessproject/presentation/square.dart';
import 'package:flutter/material.dart';

class ChessBoard extends StatelessWidget {
  const ChessBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 600,
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemCount: 64,
        itemBuilder: (context, index) {
          return Square(
            isWhite: index ~/ 8 % 2 == 0 ? index % 2 == 0 : !(index % 2 == 0),
          );
        },
      ),
    );
  }
}
