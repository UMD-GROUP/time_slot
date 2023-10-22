part of 'user_account_bloc.dart';

class UserAccountState extends Equatable {
  UserAccountState(
      {this.message = '',
      this.addCardStatus = ResponseStatus.pure,
      required this.user,
      required this.stores,
      this.getUserStatus = ResponseStatus.pure,
      this.getStoresStatus = ResponseStatus.pure,
      this.addStoreStatus = ResponseStatus.pure});
  ResponseStatus addStoreStatus;
  ResponseStatus addCardStatus;
  ResponseStatus getUserStatus;
  ResponseStatus getStoresStatus;
  String message;
  UserModel user;
  List<StoreModel> stores;

  UserAccountState copyWith({
    ResponseStatus? addStoreStatus,
    ResponseStatus? addCardStatus,
    ResponseStatus? getUserStatus,
    ResponseStatus? getStoresStatus,
    UserModel? user,
    String? message,
    List<StoreModel>? stores,
  }) =>
      UserAccountState(
          stores: stores ?? this.stores,
          user: user ?? this.user,
          getStoresStatus: getUserStatus ?? this.getStoresStatus,
          message: message ?? this.message,
          getUserStatus: getUserStatus ?? this.getUserStatus,
          addStoreStatus: addStoreStatus ?? this.addStoreStatus,
          addCardStatus: addCardStatus ?? this.addCardStatus);

  @override
  List<Object> get props => [
        user,
        addStoreStatus,
        addCardStatus,
        message,
        getUserStatus,
        stores,
        getUserStatus
      ];
}
