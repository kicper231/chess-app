import 'package:bloc/bloc.dart';
import 'package:chessproject/datalayer/models/board.dart';
import 'package:chessproject/datalayer/repo/repo.dart';

import 'package:equatable/equatable.dart';
part 'game_managment_event.dart';
part 'game_managment_state.dart';

class GameManagmentBloc extends Bloc<GameManagmentEvent, GameManagmentState> {
  Game chessGame;

  GameManagmentBloc({required this.chessGame}) : super(GameManagmentInitial()) {
    on<GameManagmentEvent>((event, emit) {});

    on<GameInitEvent>((event, emit) {
      emit(GameManagmentSettings());
    });

    on<GameStartEvent>((event, emit) {
      emit(GameManagmentOnGoing());
    });

    on<GameOnGoing>((event, emit) {
      emit(GameManagmentOnGoing());
    });

    add(GameInitEvent());
  }
}
