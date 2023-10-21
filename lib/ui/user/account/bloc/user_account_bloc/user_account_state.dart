part of 'user_account_bloc.dart';

class UserAccountState extends Equatable {
  UserAccountState(
      {this.message = '',
      this.addCardStatus = ResponseStatus.pure,
      this.addStoreStatus = ResponseStatus.pure});
  ResponseStatus addStoreStatus;
  ResponseStatus addCardStatus;
  String message;

  UserAccountState copyWith({
    ResponseStatus? addStoreStatus,
    ResponseStatus? addCardStatus,
    String? message,
  }) =>
      UserAccountState(
          message: message ?? this.message,
          addStoreStatus: addStoreStatus ?? this.addStoreStatus,
          addCardStatus: addCardStatus ?? this.addCardStatus);

  @override
  List<Object> get props => [addStoreStatus, addCardStatus, message];
}
