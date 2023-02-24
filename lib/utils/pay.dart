import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

Future<PaymentConfiguration> _googlePayConfigFuture =
    PaymentConfiguration.fromAsset('json/google_pay.json');

class GPayButton extends StatelessWidget {
  final List<PaymentItem> paymentItems;
  const GPayButton({super.key, required this.paymentItems});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaymentConfiguration>(
      future: _googlePayConfigFuture,
      builder: (context, snapshot) => snapshot.hasData
          ? GooglePayButton(
              paymentConfiguration: snapshot.data!,
              paymentItems: paymentItems,
              type: GooglePayButtonType.buy,
              onPaymentResult: (_) {}, // FIXME
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
