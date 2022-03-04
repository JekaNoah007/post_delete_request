import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:post_delete_request/api/user_service.dart';
import 'package:post_delete_request/models/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    final userService = UserService();

    on<UserCreateEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          final model = await userService.postUser(event.name, event.job);
          emit(UserLoadedState(model: model));
        } catch (e) {
          emit(UserErrorState(message: e.toString()));
        }
      },
    );
    on<UserUpdateEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          final model = await userService.putUser(event.name, event.job);
          emit(UserLoadedState(model: model));
        } catch (e) {
          emit(UserErrorState(message: e.toString()));
        }
      },
    );

    on<UserDeleteEvent>(
      (event, emit) async {
        emit(UserLoadingState());
        try {
          final model = await userService.deleteUser(event.name, event.job);
          emit(UserLoadedState(model: model));
        } catch (e) {
          emit(UserErrorState(message: e.toString()));
        }
      },
    );
  }
}
