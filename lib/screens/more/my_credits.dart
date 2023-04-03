import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

class MyCredits extends StatelessWidget {
  const MyCredits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Credits"),
      ),
      body: StreamBuilder(
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
              if (data['userId'] == FirebaseAuth.instance.currentUser!.uid) {
                payments.add(data);
              }
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
        },
      ),
    );
  }
}
