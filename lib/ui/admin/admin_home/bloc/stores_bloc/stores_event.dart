part of 'stores_bloc.dart';

@immutable
abstract class StoresEvent {}

class GetStoresEvent extends StoresEvent {
  GetStoresEvent(this.ownerId);
  String ownerId;
}

class UpdateStoreEvent extends StoresEvent {
  UpdateStoreEvent(this.store);
  StoreModel store;
}

class DeleteStoreEvent extends StoresEvent {
  DeleteStoreEvent(this.docId);
  String docId;
}
