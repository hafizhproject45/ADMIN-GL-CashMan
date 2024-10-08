import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../domain/entities/faq/faq_entity.dart';
import '../../widgets/global/my_app_bar.dart';

class DetailFaqPage extends StatefulWidget {
  const DetailFaqPage({super.key});

  @override
  State<DetailFaqPage> createState() => _DetailFaqPageState();
}

class _DetailFaqPageState extends State<DetailFaqPage> {
  final FaqEntity entity = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Detail FAQ',
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
