part of 'game_managment_bloc.dart';

abstract class GameManagmentState extends Equatable {
  const GameManagmentState();
}

class GameManagmentInitial extends GameManagmentState {
  @override
  List<Object> get props => [];
}

class GameManagmentSettings extends GameManagmentState {
  Game chessGame;
  GameManagmentSettings({required this.chessGame});

  @override
  List<Object> get props => [chessGame];
}

class GameManagmentOnGoing extends GameManagmentState {
  Game chessGame;
  GameManagmentOnGoing({required this.chessGame});

  @override
  List<Object> get props => [identityHashCode(this)];
}

class GameManagmentEnd extends GameManagmentState {
  bool isWhiteTurn;
  GameManagmentEnd({required this.isWhiteTurn});

  @override
  List<Object> get props => [];
}

class GameManagmentTimer extends GameManagmentState {
  Game chessGame;
  GameManagmentTimer({required this.chessGame});

  @override
  List<Object> get props => [identityHashCode(this)];
}
