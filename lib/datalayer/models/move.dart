import 'package:chessproject/datalayer/models/figures.dart';

class Move {
  final PieceType typ;
  final int to;
  final int from;
  final bool isEnPessant;

  const Move(
      {required this.typ,
      required this.to,
      required this.from,
      required this.isEnPessant});
}
