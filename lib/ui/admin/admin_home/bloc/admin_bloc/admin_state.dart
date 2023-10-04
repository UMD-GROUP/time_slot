part of 'admin_bloc.dart';

class AdminState extends Equatable {
  AdminState(
      {this.addBannerStatus = ResponseStatus.pure,
      this.deleteBannerStatus = ResponseStatus.pure,
      this.message = '',
      this.updatePricesStatus = ResponseStatus.pure});

  ResponseStatus addBannerStatus;
  ResponseStatus deleteBannerStatus;
  ResponseStatus updatePricesStatus;
  String message;

  AdminState copyWith({
    ResponseStatus? addBannerStatus,
    ResponseStatus? deleteBannerStatus,
    ResponseStatus? updatePricesStatus,
    String? message,
  }) =>
      AdminState(
        message: message ?? this.message,
        addBannerStatus: addBannerStatus ?? this.addBannerStatus,
        updatePricesStatus: updatePricesStatus ?? this.updatePricesStatus,
        deleteBannerStatus: deleteBannerStatus ?? this.deleteBannerStatus,
      );
  @override
  List<Object> get props =>
      [addBannerStatus, deleteBannerStatus, updatePricesStatus, message];
}
