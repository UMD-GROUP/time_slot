import 'package:time_slot/data/models/data_from_admin_model.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class DataFromAdminState extends Equatable {
  DataFromAdminState(
      {required this.status,
      this.data,
      required this.message,
      required this.index});
  ResponseStatus status;
  DataFromAdminModel? data;
  String message;
  int index;

  DataFromAdminState copyWith(
          {ResponseStatus? status,
          DataFromAdminModel? data,
          String? message,
          int? index}) =>
      DataFromAdminState(
          index: index ?? this.index,
          message: message ?? this.message,
          data: data ?? this.data,
          status: status ?? this.status);

  @override
  List<Object?> get props => [status, data, message, index];
}
