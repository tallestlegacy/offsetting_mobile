import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:offsetting_mobile/utils/pay.dart';
import 'package:pay/pay.dart';
import 'package:intl/intl.dart';

import '../utils/store.dart';

class Credits extends StatefulWidget {
  const Credits({super.key});

  @override
  State<Credits> createState() => _CreditsState();
}

class _CreditsState extends State<Credits> {
  String amount = "00.00";
  String note = "Make some magic";

  var amountController = TextEditingController();
  var noteController = TextEditingController();

  @override
  initState() {
    /* amountController.addListener(() {
      setState(() {
        amount = amountController.text;
      });
    });
    noteController.addListener(() {
      setState(() {
        note = noteController.text;
      });
    }); */

    super.initState();
  }

  @override
  dispose() {
    amountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var projectsStore = Get.put(ProjectsStore());

    void onGooglePayResult(paymentResult) async {
      print("Saving data");

      await FirebaseFirestore.instance.collection("payments").add({
        "userId": FirebaseAuth.instance.currentUser!.uid,
        "userName": FirebaseAuth.instance.currentUser!.displayName,
        "amount": double.parse(amountController.text),
        "time": DateTime.now(),
        "note": noteController.text,
      });
      amountController.clear();
      noteController.clear();
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Credits"),
          bottom: const TabBar(tabs: [
            Tab(text: "General"),
            Tab(text: "Contributions"),
          ]),
        ),
        body: TabBarView(
          children: [
            //*  General Information
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("payments").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }

                      List payments = [];

                      if (snapshot.hasData) {
                        for (var document in snapshot.data!.docs) {
                          Map<String, dynamic> data = document.data();
                          payments.add(data);
                        }

                        payments.reversed;

                        return Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.account_balance_rounded),
                                title: const Text("Total Contributions"),
                                subtitle: Text(
                                    "\$ ${payments.map((e) => e["amount"]).reduce((value, element) => value + element)}"),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: const Icon(Icons.savings_rounded),
                                title: const Text("Your Credits"),
                                subtitle: (payments
                                        .contains((e) => e["userId"] == FirebaseAuth.instance.currentUser!.uid))
                                    ? Text(
                                        "\$ ${payments.where((e) => e["userId"] == FirebaseAuth.instance.currentUser!.uid).map((e) => e["amount"]).reduce((value, element) => value + element)}")
                                    : const Text("\$ 0.0"),
                              ),
                            ],
                          ),
                        );
                      }
                      return Card(
                        child: Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.account_balance_rounded),
                              title: const Text("Total Contributions"),
                              subtitle: Text("\$ 0.0}"),
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
                      );
                    }),

                const Divider(height: 50),
                //* G-PAY section
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    icon: const Icon(Icons.money_rounded),
                    helperText: "I want to contribute ${amountController.text}",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: noteController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.favorite_rounded),
                    helperText: "Leave a note",
                  ),
                ),
                const SizedBox(height: 30),
                GPayButton(
                  paymentItems: [
                    PaymentItem(
                      amount: amountController.text,
                      label: "Credit",
                      status: PaymentItemStatus.final_price,
                    ),
                  ],
                  onPaymentResult: onGooglePayResult,
                ),
              ],
            ),
            //*  Contributors
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("payments").snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  List payments = [];

                  if (snapshot.hasData) {
                    for (var document in snapshot.data!.docs) {
                      Map<String, dynamic> data = document.data();
                      payments.add(data);
                    }

                    payments.reversed;

                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var el = payments[index];
                        var format = DateFormat();
                        String time = format.format(DateTime.parse(el["time"].toDate().toString()));
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                          child: ListTile(
                            leading: Icon(
                              Icons.rocket_rounded,
                              color: el['userId'] == FirebaseAuth.instance.currentUser!.uid
                                  ? Theme.of(context).colorScheme.tertiary
                                  : null,
                            ),
                            title: Text(el["userName"]),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Wrap(
                                  spacing: 4,
                                  direction: Axis.vertical,
                                  children: [
                                    Text("\$ ${el["amount"]}"),
                                    Text(time),
                                    Text("Note : ${el["note"]}"),
                                  ],
                                ),
                                if (index < payments.length - 1)
                                  const Divider(
                                    height: 30,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: payments.length,
                    );
                  }

                  return const LinearProgressIndicator();
                }),
          ],
        ),
      ),
    );
  }
}
