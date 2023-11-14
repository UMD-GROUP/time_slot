part of 'reserve_bloc.dart';

@immutable
abstract class ReserveEvent {}

class GetAllReservesEvent extends ReserveEvent {}

class UpdateTheReserveEvent extends ReserveEvent {
  UpdateTheReserveEvent(this.reserve);
  ReserveModel reserve;
}

class DeleteTheReserveEvent extends ReserveEvent {
  DeleteTheReserveEvent(this.docId);
  String docId;
}

class CreateTheReserveEvent extends ReserveEvent {
  CreateTheReserveEvent(this.reserve);
  ReserveModel reserve;
}

class ChangeCurrentReserveEvent extends ReserveEvent {
  ChangeCurrentReserveEvent(this.day, this.reserves);
  DateTime? day;
  List<ReserveModel> reserves;
}
