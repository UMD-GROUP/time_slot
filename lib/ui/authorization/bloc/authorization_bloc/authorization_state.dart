part of 'authorization_bloc.dart';

@immutable
class AuthorizationState extends Equatable {
  ResponseStatus status;
  String message;

  AuthorizationState({required this.status, required this.message});

  copyWith({ResponseStatus? status, String? message}) => AuthorizationState(
      status: status ?? this.status, message: message ?? this.message);

  @override
  List<Object?> get props => [status, message];
}
