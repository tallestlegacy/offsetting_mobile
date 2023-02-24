import 'package:flutter/material.dart';
import 'package:offsetting_mobile/components/text.dart';
import 'package:offsetting_mobile/utils/pay.dart';
import 'package:pay/pay.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  void onGooglePayResult(paymentResult) {
    // Send the resulting Google Pay token to your server / PSP
  }

  @override
  Widget build(BuildContext context) {
    Future<PaymentConfiguration> _googlePayConfigFuture =
        PaymentConfiguration.fromAsset('json/google_pay.json');
    const _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: '99.99',
        status: PaymentItemStatus.final_price,
      )
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Credits"),
          bottom: const TabBar(tabs: [
            Tab(text: "General"),
            Tab(text: "Contributors"),
          ]),
        ),
        body: TabBarView(
          children: [
            //*  General Information
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.account_balance_rounded),
                        title: const Text("Total Contributions"),
                        subtitle: const Text("\$ 00.00"),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.savings_rounded),
                        title: const Text("Your Credits"),
                        subtitle: const Text("\$ 00.00"),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const Divider(height: 50),
                //* G-PAY section
                // const GPayButton(paymentItems: _paymentItems),
              ],
            ),
            //*  Contributors
            ListView.separated(
              itemBuilder: (context, index) {
                return const Text(
                    "Contributors will go here"); // FIXME add appropriate content
              },
              itemCount: 1,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )
          ],
        ),
      ),
    );
  }
}
