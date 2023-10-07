part of 'admin_bloc.dart';

class AdminState extends Equatable {
  AdminState(
      {this.addBannerStatus = ResponseStatus.pure,
      this.deleteBannerStatus = ResponseStatus.pure,
      this.updateOthersStatus = ResponseStatus.pure,
      this.updateOrderState = ResponseStatus.pure,
      this.userUpdatingStatus = ResponseStatus.pure,
      this.message = '',
      this.updatePricesStatus = ResponseStatus.pure});

  ResponseStatus addBannerStatus;
  ResponseStatus deleteBannerStatus;
  ResponseStatus updatePricesStatus;
  ResponseStatus updateOthersStatus;
  ResponseStatus updateOrderState;
  ResponseStatus userUpdatingStatus;
  String message;

  AdminState copyWith({
    ResponseStatus? addBannerStatus,
    ResponseStatus? deleteBannerStatus,
    ResponseStatus? updatePricesStatus,
    ResponseStatus? updateOthersStatus,
    ResponseStatus? updateOrderState,
    ResponseStatus? userUpdatingStatus,

    String? message,
  }) =>
      AdminState(
        userUpdatingStatus: userUpdatingStatus??this.userUpdatingStatus,
        updateOthersStatus: updateOthersStatus ?? this.updateOthersStatus,
        message: message ?? this.message,
        updateOrderState: updateOrderState ?? this.updateOrderState,
        addBannerStatus: addBannerStatus ?? this.addBannerStatus,
        updatePricesStatus: updatePricesStatus ?? this.updatePricesStatus,
        deleteBannerStatus: deleteBannerStatus ?? this.deleteBannerStatus,
      );
  @override
  List<Object> get props => [
    userUpdatingStatus,
        addBannerStatus,
        deleteBannerStatus,
        updatePricesStatus,
        updateOrderState,
        message,
        updateOthersStatus
      ];
}
