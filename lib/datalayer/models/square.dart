import 'package:equatable/equatable.dart';
import 'package:chessproject/datalayer/models/figures.dart';

class Square extends Equatable {
  ChessPiece? figure;
  final bool isWhite;
  bool isChoose;
  bool isValid;
  Square(
      {this.figure,
      required this.isWhite,
      required this.isChoose,
      required this.isValid});

  @override
  List<Object?> get props => [figure, isWhite];
}
