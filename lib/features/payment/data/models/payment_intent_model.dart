import 'package:food_delivery_app/features/payment/domain/entities/payment_intent_entity.dart';

class PaymentIntentModel extends PaymentIntentEntity {
  const PaymentIntentModel({
    required super.id,
    required super.clientSecret,
    required super.amount,
    required super.currency,
  });

  factory PaymentIntentModel.fromJson(Map<String, dynamic> json) {
    return PaymentIntentModel(
      id: json['id'] as String,
      clientSecret: json['client_secret'] as String,
      amount: json['amount'] as int,
      currency: json['currency'] as String,
    );
  }
}
