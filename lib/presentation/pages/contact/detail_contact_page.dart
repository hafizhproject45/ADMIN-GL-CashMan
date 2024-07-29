import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailContactPage extends StatefulWidget {
  const DetailContactPage({super.key});

  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  final int id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Phone ID: $id'),
      ),
    );
  }
}
