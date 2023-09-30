part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  UserState({this.status = ResponseStatus.pure, this.user, this.message = ''});
  UserModel? user;
  ResponseStatus status;
  String? message;

  UserState copyWith(
          {UserModel? user, String? message, ResponseStatus? responseStatus}) =>
      UserState(
          message: this.message ?? message,
          status: responseStatus ?? status,
          user: this.user ?? user);

  @override
  List<Object?> get props => [user, status, message];
}
