part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  UserModel model;
  UserLoadedState({
    required this.model,
  });
}

class UserErrorState extends UserState {
  String message;
  UserErrorState({
    required this.message,
  });
}
