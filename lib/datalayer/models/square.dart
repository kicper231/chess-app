import 'package:equatable/equatable.dart';
import 'package:chessproject/datalayer/models/figures.dart';

class Square extends Equatable {
  ChessPiece? figure;
  final bool isWhite;
  bool isChoose;
  bool isValid;
  bool? isEnPessant;

  int index;
  Square({
    this.figure,
    required this.isWhite,
    required this.isChoose,
    required this.isValid,
    required this.index,
  });

  @override
  List<Object?> get props => [figure, isWhite];
}
