import 'package:dio/dio.dart';

class PaymentsRemoteDataSource {
  final Dio dio;
  PaymentsRemoteDataSource(this.dio);

  Future<String> createPaymentIntent({
    required int amountMinorUnits,
    required String currency,
    String? description,
  }) async {
    final response = await dio.post(
      '/payments/create-intent',
      data: {
        'amount': amountMinorUnits,
        'currency': currency,
        if (description != null) 'description': description,
      },
    );
    if (response.data is Map<String, dynamic>) {
      final map = response.data as Map<String, dynamic>;
      final clientSecret = map['clientSecret'] as String?;
      if (clientSecret == null) {
        throw Exception('Respuesta inválida: falta clientSecret');
      }
      return clientSecret;
    }
    throw Exception('Respuesta inválida del servidor');
  }
}
