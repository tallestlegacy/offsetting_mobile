import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offsetting_mobile/utils/store.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var feedsStoreController = Get.put(FeedsStore());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Debug"),
      ),
      body: Obx(
        () => Center(
          child: Text("${feedsStoreController.feeds[0]}"),
        ),
      ),
    );
  }
}
