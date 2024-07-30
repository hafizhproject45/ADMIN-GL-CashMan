import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../domain/entities/contact/contact_entity.dart';
import '../../widgets/global/my_app_bar.dart';

class DetailContactPage extends StatefulWidget {
  const DetailContactPage({super.key});

  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  final ContactEntity entity = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Detail Contact',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
