import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../widgets/global/my_app_bar.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Add Contact',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const Center(
        child: Text('Add Contact Page'),
      ),
    );
  }
}
