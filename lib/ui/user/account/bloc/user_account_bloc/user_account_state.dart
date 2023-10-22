part of 'user_account_bloc.dart';

class UserAccountState extends Equatable {
  UserAccountState(
      {this.message = '',
      this.addCardStatus = ResponseStatus.pure,
      required this.user,
      this.getUserStatus = ResponseStatus.pure,
      this.addStoreStatus = ResponseStatus.pure});
  ResponseStatus addStoreStatus;
  ResponseStatus addCardStatus;
  ResponseStatus getUserStatus;
  String message;
  UserModel user;

  UserAccountState copyWith({
    ResponseStatus? addStoreStatus,
    ResponseStatus? addCardStatus,
    ResponseStatus? getUserStatus,
    UserModel? user,
    String? message,
  }) =>
      UserAccountState(
          user: user ?? this.user,
          message: message ?? this.message,
          getUserStatus: getUserStatus ?? this.getUserStatus,
          addStoreStatus: addStoreStatus ?? this.addStoreStatus,
          addCardStatus: addCardStatus ?? this.addCardStatus);

  @override
  List<Object> get props =>
      [user, addStoreStatus, addCardStatus, message, getUserStatus];
}
