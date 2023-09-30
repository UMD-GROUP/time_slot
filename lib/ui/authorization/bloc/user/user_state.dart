part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  UserModel? user;
  ResponseStatus status;
  String? message;

  UserState({this.status = ResponseStatus.pure, this.user, this.message = ''});

  copyWith(
          {UserModel? user, String? message, ResponseStatus? responseStatus}) =>
      UserState(
          message: this.message ?? message,
          status: responseStatus ?? status,
          user: this.user ?? user);

  @override
  List<Object?> get props => [user, status, message];
}
