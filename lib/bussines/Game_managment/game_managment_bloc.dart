import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'game_managment_event.dart';
part 'game_managment_state.dart';

class GameManagmentBloc extends Bloc<GameManagmentEvent, GameManagmentState> {
  GameManagmentBloc() : super(GameManagmentInitial()) {
    on<GameManagmentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
