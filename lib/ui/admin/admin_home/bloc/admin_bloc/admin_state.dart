part of 'admin_bloc.dart';

class AdminState extends Equatable {
  AdminState(
      {this.addBannerStatus = ResponseStatus.pure,
      this.deleteBannerStatus = ResponseStatus.pure,
      this.updateOthersStatus = ResponseStatus.pure,
      this.message = '',
      this.updatePricesStatus = ResponseStatus.pure});

  ResponseStatus addBannerStatus;
  ResponseStatus deleteBannerStatus;
  ResponseStatus updatePricesStatus;
  ResponseStatus updateOthersStatus;
  String message;

  AdminState copyWith({
    ResponseStatus? addBannerStatus,
    ResponseStatus? deleteBannerStatus,
    ResponseStatus? updatePricesStatus,
    ResponseStatus? updateOthersStatus,
    String? message,
  }) =>
      AdminState(
        updateOthersStatus: updateOthersStatus ?? this.updateOthersStatus,
        message: message ?? this.message,
        addBannerStatus: addBannerStatus ?? this.addBannerStatus,
        updatePricesStatus: updatePricesStatus ?? this.updatePricesStatus,
        deleteBannerStatus: deleteBannerStatus ?? this.deleteBannerStatus,
      );
  @override
  List<Object> get props => [
        addBannerStatus,
        deleteBannerStatus,
        updatePricesStatus,
        message,
        updateOthersStatus
      ];
}
