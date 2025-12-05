abstract class PaymentEvent {}

class StartCardPayment extends PaymentEvent {
  final int amountMinorUnits; // e.g. cents
  final String currency; // e.g. "usd"
  final String? description;

  StartCardPayment({
    required this.amountMinorUnits,
    required this.currency,
    this.description,
  });
}
