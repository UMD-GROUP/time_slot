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
  UpdateOtherEvent(this.deliveryNote, this.memberPercent, {this.data});
  String deliveryNote;
  int memberPercent;
  DataFromAdminModel? data;
}

class UpdateOrderEvent extends AdminEvent {
  UpdateOrderEvent(this.order, this.percent, {this.photo});
  OrderModel order;
  int percent;
  String? photo;
}

class UpdateUserBEvent extends AdminEvent {
  UpdateUserBEvent(this.user);
  UserModel user;
}
