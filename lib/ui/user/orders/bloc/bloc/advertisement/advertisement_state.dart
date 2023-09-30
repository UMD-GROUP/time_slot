import 'package:time_slot/utils/tools/file_importers.dart';

class AdvertisementState extends Equatable {
  AdvertisementState(
      {required this.status,
      this.banners,
      required this.message,
      required this.index});
  ResponseStatus status;
  List? banners;
  String message;
  int index;

  AdvertisementState copyWith(
          {ResponseStatus? status,
          List? banners,
          String? message,
          int? index}) =>
      AdvertisementState(
          index: index ?? this.index,
          message: message ?? this.message,
          banners: banners ?? this.banners,
          status: status ?? this.status);

  @override
  List<Object?> get props => [status, banners, message, index];
}
