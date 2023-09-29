abstract class AdvertisementEvent {}

class GetBannersEvent extends AdvertisementEvent {}

class ChangeIndexEvent extends AdvertisementEvent {
  int index;
  ChangeIndexEvent(this.index);
}
