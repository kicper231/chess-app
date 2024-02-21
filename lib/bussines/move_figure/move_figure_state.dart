part of 'move_figure_bloc.dart';

sealed class MoveFigureState extends Equatable {
  bool isWhiteTurn = true;
  MoveFigureState({required this.isWhiteTurn});

  @override
  List<Object> get props => [];
}

final class MoveFigureInitial extends MoveFigureState {
  MoveFigureInitial({required super.isWhiteTurn});
}

class StartMoving extends MoveFigureState {
  StartMoving({required super.isWhiteTurn});
}

class EndMoving extends MoveFigureState {
  EndMoving({required super.isWhiteTurn});
}
