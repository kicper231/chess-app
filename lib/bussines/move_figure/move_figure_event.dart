part of 'move_figure_bloc.dart';

sealed class MoveFigureEvent extends Equatable {
  const MoveFigureEvent();
}

class TapOnFigure extends MoveFigureEvent {
  final int pieceIndex;
  final Piece? tapPiece;

  const TapOnFigure({required this.pieceIndex, required this.tapPiece});
  @override
  List<Object> get props => [pieceIndex];
}

class TapOnValidMove extends MoveFigureEvent {
  final int moveIndex;

  const TapOnValidMove({required this.moveIndex});
  @override
  List<Object> get props => [moveIndex];
}

class CaptureFigure extends MoveFigureEvent {
  final int moveIndex;
  const CaptureFigure({required this.moveIndex});
  @override
  List<Object> get props => [moveIndex];
}

class ResetMoves extends MoveFigureEvent {
  @override
  List<Object> get props => [];
}
