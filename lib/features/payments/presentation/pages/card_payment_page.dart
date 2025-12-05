import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../../presentation/bloc/payment_bloc.dart';
import '../../presentation/bloc/payment_event.dart';
import '../../presentation/bloc/payment_state.dart';

class CardPaymentPage extends StatefulWidget {
  final int amountMinorUnits; // cents
  final String currency; // e.g. "usd"
  final String? description;
  final bool autoPayTest;

  const CardPaymentPage({
    super.key,
    required this.amountMinorUnits,
    required this.currency,
    this.description,
    this.autoPayTest = false,
  });

  @override
  State<CardPaymentPage> createState() => _CardPaymentPageState();
}

class _CardPaymentPageState extends State<CardPaymentPage> {
  CardFieldInputDetails? _cardDetails;

  @override
  void initState() {
    super.initState();
    if (widget.autoPayTest) {
      // Trigger mock payment automatically
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final bloc = context.read<PaymentBloc>();
        bloc.add(StartCardPayment(
          amountMinorUnits: widget.amountMinorUnits,
          currency: widget.currency,
          description: widget.description,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final amountLabel = _formatAmount(widget.amountMinorUnits, widget.currency);

    return Scaffold(
      appBar: AppBar(title: Text('Pagar $amountLabel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pago exitoso')),
              );
              Navigator.of(context).pop(true);
            }
            if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Fallo el pago: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            final isProcessing = state is PaymentProcessing;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!widget.autoPayTest) ...[
                  const Text('Detalles de tarjeta'),
                  const SizedBox(height: 12),
                  CardField(
                    onCardChanged: (details) => setState(() => _cardDetails = details),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isProcessing
                      ? null
                      : () {
                          context.read<PaymentBloc>().add(
                                StartCardPayment(
                                  amountMinorUnits: widget.amountMinorUnits,
                                  currency: widget.currency,
                                  description: widget.description,
                                ),
                              );
                        },
                  child: isProcessing
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(widget.autoPayTest ? 'Procesando pago de prueba...' : 'Pagar $amountLabel'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatAmount(int minorUnits, String currency) {
    final major = (minorUnits / 100).toStringAsFixed(2);
    return '$currency $major';
  }
}
