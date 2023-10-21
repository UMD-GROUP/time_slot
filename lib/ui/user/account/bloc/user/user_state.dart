part of 'user_bloc.dart';

@immutable
class UserState extends Equatable {
  UserState({this.status = ResponseStatus.pure, this.user, this.message = ''});
  UserModel? user;
  ResponseStatus status;
  String? message;

  UserState copyWith(
          {UserModel? user, String? message, ResponseStatus? status}) =>
      UserState(
          message: message ?? this.message,
          status: status ?? this.status,
          user: user ?? this.user);

  @override
  List<Object?> get props => [user, status, message];
}
