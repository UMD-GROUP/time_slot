part of 'stores_bloc.dart';

@immutable
class StoresState extends Equatable {
  StoresState(
      {this.message = '',
      this.deletingStatus = ResponseStatus.pure,
      this.gettingStatus = ResponseStatus.pure,
      required this.stores,
      this.updatingStatus = ResponseStatus.pure});
  ResponseStatus gettingStatus;
  ResponseStatus updatingStatus;
  ResponseStatus deletingStatus;
  List stores;
  String message;

  StoresState copyWith({
    ResponseStatus? gettingStatus,
    ResponseStatus? updatingStatus,
    ResponseStatus? deletingStatus,
    List? stores,
    String? message,
  }) =>
      StoresState(
          message: message ?? this.message,
          deletingStatus: deletingStatus ?? this.deletingStatus,
          gettingStatus: gettingStatus ?? this.gettingStatus,
          stores: stores ?? this.stores,
          updatingStatus: updatingStatus ?? this.updatingStatus);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [gettingStatus, updatingStatus, deletingStatus, stores, message];
}
