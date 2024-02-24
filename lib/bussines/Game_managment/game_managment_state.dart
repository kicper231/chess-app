part of 'game_managment_bloc.dart';

abstract class GameManagmentState extends Equatable {
  const GameManagmentState();
}

class GameManagmentInitial extends GameManagmentState {
  @override
  List<Object> get props => [];
}

class GameManagmentSettings extends GameManagmentState {
  final Game chessGame;
  const GameManagmentSettings({required this.chessGame});

  @override
  List<Object> get props => [chessGame];
}

class GameManagmentOnGoing extends GameManagmentState {
  final Game chessGame;
  const GameManagmentOnGoing({required this.chessGame});

  @override
  List<Object> get props => [identityHashCode(this)];
}

class GameManagmentEnd extends GameManagmentState {
  final bool isWhiteTurn;
  const GameManagmentEnd({required this.isWhiteTurn});

  @override
  List<Object> get props => [];
}

class GameManagmentTimer extends GameManagmentState {
  final Game chessGame;
  const GameManagmentTimer({required this.chessGame});

  @override
  List<Object> get props => [identityHashCode(this)];
}
