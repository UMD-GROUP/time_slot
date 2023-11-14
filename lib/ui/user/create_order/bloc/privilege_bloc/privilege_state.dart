part of 'privilege_bloc.dart';

@immutable
class PrivilegeState extends Equatable {
  PrivilegeState(
      {this.reserve,
      this.message = '',
      this.promoCode,
      this.promoCodeStatus = ResponseStatus.pure,
      this.reservesStatus = ResponseStatus.pure});
  ResponseStatus promoCodeStatus;
  ResponseStatus reservesStatus;
  PromoCodeModel? promoCode;
  ReserveModel? reserve;
  String message;

  PrivilegeState copyWith({
    ResponseStatus? promoCodeStatus,
    ResponseStatus? reservesStatus,
    PromoCodeModel? promoCode,
    ReserveModel? reserve,
    String? message,
  }) =>
      PrivilegeState(
          reserve: reserve ?? this.reserve,
          message: message ?? this.message,
          promoCode: promoCode ?? this.promoCode,
          promoCodeStatus: promoCodeStatus ?? this.promoCodeStatus,
          reservesStatus: reservesStatus ?? this.reservesStatus);

  @override
  List<Object?> get props =>
      [promoCodeStatus, reservesStatus, promoCode, reserve, message];
}
