import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Debug"),
      ),
      body: true
          ? Center(
              child: Text(FirebaseAuth.instance.currentUser!.toString()),
            )

          // ignore: dead_code
          : StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("debug").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                if (snapshot.hasData) {
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data["bandName"].toString()),
                        subtitle: Text("Rating => ${data["rating"]}"),
                        onTap: () {
                          FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentSnapshot freshSnapshot =
                                await transaction.get(document.reference);
                            await transaction.update(
                              freshSnapshot.reference,
                              {
                                "rating": freshSnapshot["rating"] + 1,
                              },
                            );
                          });
                        },
                      );
                    }).toList(),
                  );
                }

                return const Text("...");
              }),
    );
  }
}
