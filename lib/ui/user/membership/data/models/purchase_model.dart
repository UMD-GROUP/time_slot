import 'package:time_slot/utils/tools/file_importers.dart';

class PurchaseModel {
  PurchaseModel(
      {required this.ownerId,
      required this.referralId,
      required this.purchaseId,
      required this.amount,
      this.cardNumber = '',
      required this.status,
      this.createdAt = '',
      this.docId = ''});

  factory PurchaseModel.fromJson(Map<String, dynamic> json) => PurchaseModel(
        docId: json['docId'] ?? '',
        cardNumber: json['cardNumber'] ?? '',
        createdAt: json['createdAt'] ?? DateTime.now().toString(),
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
            : PurchaseStatus.created,
      );
  final String ownerId;
  final String referralId;
  final int purchaseId;
  final num amount;
  final PurchaseStatus status;
  final String docId;
  final String createdAt;
  String cardNumber;

  Map<String, dynamic> toJson() => {
        'ownerId': ownerId,
        'referralId': referralId,
        'purchaseId': purchaseId,
        'amount': amount,
        'docId': docId,
        'createdAt': createdAt,
        'cardNumber': cardNumber,
        'status': status.toString().split('.').last, // Convert enum to String
      };
}
