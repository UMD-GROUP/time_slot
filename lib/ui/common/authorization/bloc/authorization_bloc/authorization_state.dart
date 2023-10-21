part of 'authorization_bloc.dart';

@immutable
class AuthorizationState extends Equatable {
  AuthorizationState({required this.status, required this.message});
  ResponseStatus status;
  String message;

  AuthorizationState copyWith({ResponseStatus? status, String? message}) =>
      AuthorizationState(
          status: status ?? this.status, message: message ?? this.message);

  @override
  List<Object?> get props => [status, message];
}
