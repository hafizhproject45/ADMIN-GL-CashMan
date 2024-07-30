import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../widgets/global/my_app_bar.dart';

class AddFaqPage extends StatefulWidget {
  const AddFaqPage({super.key});

  @override
  State<AddFaqPage> createState() => _AddFaqPageState();
}

class _AddFaqPageState extends State<AddFaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Add FAQ',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Center(
        child: Text('Add FAQ Page'),
      ),
    );
  }
}
