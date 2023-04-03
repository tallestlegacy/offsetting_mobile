import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

Future<PaymentConfiguration> _googlePayConfigFuture = PaymentConfiguration.fromAsset('json/google_pay.json');

class GPayButton extends StatelessWidget {
  final List<PaymentItem> paymentItems;
  final Function(Map<String, dynamic>) onPaymentResult;
  const GPayButton({super.key, required this.paymentItems, required this.onPaymentResult});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaymentConfiguration>(
      future: _googlePayConfigFuture,
      builder: (context, snapshot) => snapshot.hasData
          ? GooglePayButton(
              paymentConfiguration: snapshot.data!,
              paymentItems: paymentItems,
              type: GooglePayButtonType.buy,
              onPaymentResult: onPaymentResult,
              loadingIndicator: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
