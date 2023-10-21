part of 'purchase_bloc.dart';

@immutable
class PurchaseEvent {}

class GetPurchasesEvent extends PurchaseEvent {}

class AddPurchaseEvent extends PurchaseEvent {
  AddPurchaseEvent(this.purchase, this.user);
  PurchaseModel purchase;
  UserModel user;
}
