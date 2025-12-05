abstract class PaymentsRepository {
  Future<String> createPaymentIntent({
    required int amountMinorUnits,
    required String currency,
    String? description,
  });
}
