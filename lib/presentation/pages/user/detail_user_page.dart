import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailUserPage extends StatefulWidget {
  const DetailUserPage({super.key});

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  final int id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('User ID: $id'),
      ),
    );
  }
}
