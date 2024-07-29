import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailFaqPage extends StatefulWidget {
  const DetailFaqPage({super.key});

  @override
  State<DetailFaqPage> createState() => _DetailFaqPageState();
}

class _DetailFaqPageState extends State<DetailFaqPage> {
  final int id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Question ID: $id'),
      ),
    );
  }
}
