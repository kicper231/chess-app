part of 'move_figure_bloc.dart';

sealed class MoveFigureState extends Equatable {
  final bool isWhiteTurn;
  const MoveFigureState({required this.isWhiteTurn});

  @override
  List<Object> get props => [];
}

final class MoveFigureInitial extends MoveFigureState {
  const MoveFigureInitial({required super.isWhiteTurn});
}

class StartMoving extends MoveFigureState {
  const StartMoving({required super.isWhiteTurn});
}

class EndMoving extends MoveFigureState {
  final bool isCheck;
  final ChessPiece? figure;
  final bool isCheckmate;
  const EndMoving(
      {required super.isWhiteTurn,
      this.figure,
      required this.isCheck,
      required this.isCheckmate});
}
