import 'package:chessproject/datalayer/models/figures.dart';

class Square {
  ChessPiece? figure;
  final bool isWhite;
  bool isChoose;
  bool isValid;
  bool? isEnPessant;
  bool? isshortCastling;
  bool? islongCasteling;

  int index;
  Square({
    this.figure,
    required this.isWhite,
    required this.isChoose,
    required this.isValid,
    required this.index,
  });
}
