part of 'user_account_bloc.dart';

abstract class UserAccountEvent {
  const UserAccountEvent();
}

class AddMarketEvent extends UserAccountEvent {
  AddMarketEvent(this.user, this.market);
  UserModel user;
  String market;
}

class AddBankingCardEvent extends UserAccountEvent {
  AddBankingCardEvent(this.bankingCard);
  BankingCardModel bankingCard;
}

class GetUserDataEvent extends UserAccountEvent {
  GetUserDataEvent(this.uid);
  String uid;
}

class GetUserStoresEvent extends UserAccountEvent {
  GetUserStoresEvent(this.ownerId);
  String ownerId;
}
