import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../domain/usecases/create_payment_intent.dart';
import 'payment_event.dart';
import 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CreatePaymentIntent createPaymentIntent;
  final bool mock;

  PaymentBloc({required this.createPaymentIntent, this.mock = false}) : super(PaymentInitial()) {
    on<StartCardPayment>(_onStartCardPayment);
  }

  Future<void> _onStartCardPayment(
    StartCardPayment event,
    Emitter<PaymentState> emit,
  ) async {
    emit(PaymentProcessing());
    try {
      if (mock) {
        await Future.delayed(const Duration(milliseconds: 800));
        emit(PaymentSuccess());
        return;
      }
      final clientSecret = await createPaymentIntent(
        amountMinorUnits: event.amountMinorUnits,
        currency: event.currency,
        description: event.description,
      );

      // Confirm with card details collected via CardField
      await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: clientSecret,
        data: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      emit(PaymentSuccess());
    } catch (e) {
      emit(PaymentFailure(e.toString()));
    }
  }
}
