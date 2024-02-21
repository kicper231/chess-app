part of 'game_managment_bloc.dart';

abstract class GameManagmentState extends Equatable {
  GameManagmentState();
}

final class GameManagmentInitial extends GameManagmentState {
  @override
  List<Object> get props => [];
}

final class GameManagmentSettings extends GameManagmentState {
  GameManagmentSettings();

  @override
  List<Object> get props => [];
}

final class GameManagmentOnGoing extends GameManagmentState {
  GameManagmentOnGoing();

  @override
  List<Object> get props => [identityHashCode(this)];
}

final class GameManagmentEnd extends GameManagmentState {
  @override
  List<Object> get props => [];
}
