part of 'promo_code_bloc.dart';

@immutable
abstract class PromoCodeEvent {}

class GetPromoCodesEvent extends PromoCodeEvent {}

class CreateNewCodeEvent extends PromoCodeEvent {
  CreateNewCodeEvent(this.promoCode);
  PromoCodeModel promoCode;
}

class DeleteCodeEvent extends PromoCodeEvent {
  DeleteCodeEvent(this.docId);
  String docId;
}
