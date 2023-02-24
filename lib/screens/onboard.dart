import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatefulWidget {
  OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final emailController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.email.toString());

  final displayNameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  String displayName = "";
  String phoneNumber = "";

  get canSubmit {
    return displayName.isNotEmpty && phoneNumber.length > 9;
  }

  @override
  Widget build(BuildContext context) {
    displayNameController.addListener(() {
      if (mounted) {
        setState(() {
          displayName = displayNameController.text;
        });
      }
    });

    phoneNumberController.addListener(() {
      if (mounted) {
        setState(() {
          phoneNumber = phoneNumberController.text;
        });
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text("Onboard"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 16,
          runSpacing: 32,
          alignment: WrapAlignment.end,
          children: [
            TextField(
              controller: emailController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Email",
              ),
              enabled: false,
            ),
            TextField(
              controller: displayNameController,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Display Name",
              ),
            ),
            TextField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: "Phone Number",
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: canSubmit
          ? FloatingActionButton.extended(
              onPressed: () async {
                var user = FirebaseAuth.instance.currentUser;
                await user?.updateDisplayName(displayName);
                // user?.updatePhoneNumber();
              },
              label: const Text("Save"),
              icon: const Icon(Icons.save_rounded),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            )
          : null,
    );
  }
}
