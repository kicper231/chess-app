part of 'move_figure_bloc.dart';

sealed class MoveFigureEvent extends Equatable {
  const MoveFigureEvent();
}

class TapOnFigure extends MoveFigureEvent {
  int pieceIndex;
  Piece? tapPiece;

  TapOnFigure({required this.pieceIndex, required this.tapPiece});
  @override
  List<Object> get props => [pieceIndex];
}

class TapOnValidMove extends MoveFigureEvent {
  late int moveIndex;

  TapOnValidMove({required this.moveIndex});
  @override
  List<Object> get props => [moveIndex];
}

class CaptureFigure extends MoveFigureEvent {
  late int moveIndex;
  CaptureFigure({required this.moveIndex});
  @override
  List<Object> get props => [moveIndex];
}

class ResetMoves extends MoveFigureEvent {
  @override
  List<Object> get props => [];
}
