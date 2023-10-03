abstract class DataFromAdminEvent {}

class GetBannersEvent extends DataFromAdminEvent {}

class ChangeIndexEvent extends DataFromAdminEvent {
  ChangeIndexEvent(this.index);
  int index;
}
