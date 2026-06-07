abstract class PaymentEvent {
  const PaymentEvent();
}

class PaymentInitiated extends PaymentEvent {
  final double totalAmount;
  const PaymentInitiated({required this.totalAmount});
}
