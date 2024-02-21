part of 'move_figure_bloc.dart';

sealed class MoveFigureState extends Equatable {
  const MoveFigureState();

  @override
  List<Object> get props => [];
}

final class MoveFigureInitial extends MoveFigureState {}

class StartMoving extends MoveFigureState {}

class EndMoving extends MoveFigureState {}
