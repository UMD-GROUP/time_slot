part of 'reserve_bloc.dart';

@immutable
class ReserveState extends Equatable {
  ReserveState(
      {this.gettingStatus = ResponseStatus.pure,
      this.updatingStatus = ResponseStatus.pure,
      this.creatingStatus = ResponseStatus.pure,
      this.currentReserve,
      this.deletingStatus = ResponseStatus.pure,
      this.message = '',
      required this.reserves});
  ResponseStatus gettingStatus;
  ResponseStatus updatingStatus;
  ResponseStatus deletingStatus;
  ResponseStatus creatingStatus;
  ReserveModel? currentReserve;
  String message;
  List reserves;

  ReserveState copyWith({
    ResponseStatus? status,
    String? message,
    List? reserves,
    ResponseStatus? updatingStatus,
    ResponseStatus? deletingStatus,
    ResponseStatus? creatingStatus,
    ResponseStatus? gettingStatus,
    ReserveModel? currentReserve,
  }) =>
      ReserveState(
          currentReserve: currentReserve ?? this.currentReserve,
          deletingStatus: deletingStatus ?? this.deletingStatus,
          creatingStatus: creatingStatus ?? this.creatingStatus,
          updatingStatus: updatingStatus ?? this.updatingStatus,
          reserves: reserves ?? this.reserves,
          message: message ?? this.message,
          gettingStatus: status ?? this.gettingStatus);

  @override
  List<Object?> get props => [
        gettingStatus,
        message,
        reserves,
        creatingStatus,
        updatingStatus,
        deletingStatus,
        currentReserve
      ];
}
