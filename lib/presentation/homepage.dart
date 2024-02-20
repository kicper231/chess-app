import 'package:chessproject/presentation/chessboard.dart';

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChessBoard(),
      backgroundColor: Color.fromARGB(255, 120, 121, 122),
    );
  }
}
