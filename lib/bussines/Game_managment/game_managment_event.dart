part of 'game_managment_bloc.dart';

abstract class GameManagmentEvent extends Equatable {
  const GameManagmentEvent();
  @override
  List<Object> get props => [];
}

class GameInitEvent extends GameManagmentEvent {}

class GameStartEvent extends GameManagmentEvent {
  int length;
  GameStartEvent({required this.length});
}

class GameOnGoing extends GameManagmentEvent {}

class GameEnd extends GameManagmentEvent {}

class WhiteTimeOut extends GameManagmentEvent {}

class BlackTimeOut extends GameManagmentEvent {}
