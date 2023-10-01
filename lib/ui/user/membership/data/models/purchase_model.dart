import 'package:time_slot/utils/tools/file_importers.dart';

class PurchaseModel {
  PurchaseModel({
    required this.ownerId,
    required this.referralId,
    required this.purchaseId,
    required this.amount,
    required this.status,
  });

  factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
        ownerId: json['ownerId'] ?? 'defaultOwnerId',
        referralId: json['referralId'] ?? 'defaultReferralId',
        purchaseId: json['purchaseId'] ?? 0,
        amount: json['amount'] ?? 0.0,
        status: json['status'] != null
            ? PurchaseStatus.values.firstWhere(
                (status) => status.toString().split('.').last == json['status'],
                orElse: () =>
                    PurchaseStatus.created, // Default status if not found
              )
            : PurchaseStatus.created, // Default status if status key is missing
      );
  final String ownerId;
  final String referralId;
  final int purchaseId;
  final num amount;
  final PurchaseStatus status;

  Map<String, dynamic> toJson() => {
        'ownerId': ownerId,
        'referralId': referralId,
        'purchaseId': purchaseId,
        'amount': amount,
        'status': status.toString().split('.').last, // Convert enum to String
      };
}
