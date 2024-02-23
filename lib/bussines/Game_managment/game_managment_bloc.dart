import 'package:bloc/bloc.dart';

import 'package:chessproject/datalayer/repo/repo.dart';

import 'package:equatable/equatable.dart';

part 'game_managment_event.dart';
part 'game_managment_state.dart';

class GameManagmentBloc extends Bloc<GameManagmentEvent, GameManagmentState> {
  Game chessGame;
  // oczywscie to przeczy zasadą dostepnosci do danych ale to maly projekt i nie ma wersji online

  GameManagmentBloc({required this.chessGame}) : super(GameManagmentInitial()) {
    on<GameManagmentEvent>((event, emit) {});

    on<GameInitEvent>((event, emit) {
      emit(GameManagmentSettings(chessGame: chessGame));
    });

    on<GameStartEvent>((event, emit) {
      chessGame.start(event.length);

      emit(GameManagmentOnGoing(chessGame: chessGame));
    });

    on<GameOnGoing>((event, emit) {
      emit(GameManagmentOnGoing(chessGame: chessGame));
    });

    on<GameEnd>((event, emit) {
      emit(GameManagmentEnd(isWhiteTurn: chessGame.isWhiteMove));
    });
    add(GameInitEvent());
    on<WhiteTimeOut>((event, emit) {
      emit(GameManagmentEnd(isWhiteTurn: chessGame.isWhiteMove));
    });
  }
}
