part of 'admin_bloc.dart';

abstract class AdminEvent {
  const AdminEvent();
}

class AddBannerEvent extends AdminEvent {
  AddBannerEvent(this.path, this.data);
  String path;
  DataFromAdminModel data;
}

class RemoveBannerEvent extends AdminEvent {
  RemoveBannerEvent(this.path, this.data);
  String path;
  DataFromAdminModel data;
}

class UpdatePricesEvent extends AdminEvent {
  UpdatePricesEvent(this.data);
  List data;
}

class UpdateOtherEvent extends AdminEvent {
  UpdateOtherEvent(this.deliveryNote, this.memberPercent);
  String deliveryNote;
  int memberPercent;
}

class UpdateOrderEvent extends AdminEvent {
  UpdateOrderEvent(this.order, this.percent);
  OrderModel order;
  int percent;
}

class UpdateUserBEvent extends AdminEvent {
  UpdateUserBEvent(this.user);
  UserModel user;
}

class UpdatePurchaseEvent extends AdminEvent {
  UpdatePurchaseEvent(this.purchase);
  PurchaseModel purchase;
}
