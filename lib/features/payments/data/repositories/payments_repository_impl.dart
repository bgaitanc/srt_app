import '../../domain/repositories/payments_repository.dart';
import '../datasources/payments_remote_data_source.dart';

class PaymentsRepositoryImpl implements PaymentsRepository {
  final PaymentsRemoteDataSource remote;
  PaymentsRepositoryImpl(this.remote);

  @override
  Future<String> createPaymentIntent({
    required int amountMinorUnits,
    required String currency,
    String? description,
  }) {
    return remote.createPaymentIntent(
      amountMinorUnits: amountMinorUnits,
      currency: currency,
      description: description,
    );
  }
}
