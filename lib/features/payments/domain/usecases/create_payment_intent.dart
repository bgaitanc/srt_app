import '../repositories/payments_repository.dart';

class CreatePaymentIntent {
  final PaymentsRepository repo;
  CreatePaymentIntent(this.repo);

  Future<String> call({
    required int amountMinorUnits,
    required String currency,
    String? description,
  }) async {
    return repo.createPaymentIntent(
      amountMinorUnits: amountMinorUnits,
      currency: currency,
      description: description,
    );
  }
}
