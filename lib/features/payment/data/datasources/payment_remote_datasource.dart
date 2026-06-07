import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:food_delivery_app/core/error/exceptions.dart';
import 'package:food_delivery_app/features/payment/data/models/payment_intent_model.dart';

abstract interface class PaymentRemoteDataSource {
  Future<PaymentIntentModel> createPaymentIntent({
    required int amountInCents,
    required String currency,
  });
}

// WARNING: In production, move PaymentIntent creation to a backend server.
// The secret key must NEVER be in a production mobile app binary.
class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final String secretKey;
  final http.Client _client;

  PaymentRemoteDataSourceImpl({
    required this.secretKey,
    http.Client? client,
  }) : _client = client ?? http.Client();

  @override
  Future<PaymentIntentModel> createPaymentIntent({
    required int amountInCents,
    required String currency,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'amount': amountInCents.toString(),
          'currency': currency,
          'automatic_payment_methods[enabled]': 'true',
        },
      );

      final json = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        return PaymentIntentModel.fromJson(json);
      }

      final error = json['error'] as Map<String, dynamic>?;
      throw ServerException(
        error?['message'] as String? ?? 'Stripe error ${response.statusCode}',
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
