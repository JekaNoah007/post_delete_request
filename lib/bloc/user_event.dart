part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserCreateEvent extends UserEvent {
  String name;
  String job;
  UserCreateEvent({
    required this.name,
    required this.job,
  });
}

class UserUpdateEvent extends UserEvent {
  String name;
  String job;
  UserUpdateEvent({
    required this.name,
    required this.job,
  });
}

class UserDeleteEvent extends UserEvent {
  String name;
  String job;
  UserDeleteEvent({
    required this.name,
    required this.job,
  });
}
