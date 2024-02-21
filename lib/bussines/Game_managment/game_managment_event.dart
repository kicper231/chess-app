part of 'game_managment_bloc.dart';

abstract class GameManagmentEvent extends Equatable {
  const GameManagmentEvent();
  @override
  List<Object> get props => [];
}

class GameInitEvent extends GameManagmentEvent {}

class GameStartEvent extends GameManagmentEvent {}

class GameOnGoing extends GameManagmentEvent {}
