import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class DetailPaymentPage extends StatefulWidget {
  const DetailPaymentPage({super.key});

  @override
  State<DetailPaymentPage> createState() => _DetailPaymentPageState();
}

class _DetailPaymentPageState extends State<DetailPaymentPage> {
  final int id = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Payment ID: $id'),
      ),
    );
  }
}
