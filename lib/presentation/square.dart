import 'package:flutter/material.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  const Square({super.key, required this.isWhite});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: isWhite
            ? Color.fromARGB(255, 201, 202, 202)
            : Color.fromARGB(255, 138, 139, 140),
        child: Image.asset('assets/pieces/pan.png', color: Colors.white));
  }
}
