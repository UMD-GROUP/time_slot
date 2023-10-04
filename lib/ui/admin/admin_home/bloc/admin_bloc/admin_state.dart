part of 'admin_bloc.dart';

class AdminState extends Equatable {
  AdminState(
      {this.addBannerStatus = ResponseStatus.pure,
      this.deleteBannerStatus = ResponseStatus.pure,
      this.message = '',
      this.addPriceStatus = ResponseStatus.pure});

  ResponseStatus addBannerStatus;
  ResponseStatus deleteBannerStatus;
  ResponseStatus addPriceStatus;
  String message;

  AdminState copyWith({
    ResponseStatus? addBannerStatus,
    ResponseStatus? deleteBannerStatus,
    ResponseStatus? addPriceStatus,
    String? message,
  }) =>
      AdminState(
        message: message ?? this.message,
        addBannerStatus: addBannerStatus ?? this.addBannerStatus,
        addPriceStatus: addPriceStatus ?? this.addPriceStatus,
        deleteBannerStatus: deleteBannerStatus ?? this.deleteBannerStatus,
      );
  @override
  List<Object> get props =>
      [addBannerStatus, deleteBannerStatus, addPriceStatus, message];
}
