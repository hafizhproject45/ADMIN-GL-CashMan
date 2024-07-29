// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/utility.dart';
import '../../../domain/entities/payment/payment_entity.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../widgets/payment/payment_card.dart';
import '../../../injection_container.dart';
import '../../cubit/payment/get_all_payment/get_all_payment_cubit.dart';
import '../../widgets/global/my_app_bar.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final getAllPaymentCubit = sl<GetAllPaymentCubit>();
  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => getAllPaymentCubit..getData(),
      child: _content(screenWidth),
    );
  }

  Widget _content(double screenWidth) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Payments',
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              onPressed: () async {
                final result = await Get.toNamed('/payment-add');
                if (result == 'refresh') {
                  await Future.delayed(const Duration(seconds: 1));
                  _onRefresh(context);
                }
              },
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: SmartRefresher(
        onRefresh: () => _onRefresh(context),
        controller: _refreshController,
        child: SingleChildScrollView(
          child: BlocBuilder<GetAllPaymentCubit, GetAllPaymentState>(
            builder: (context, state) {
              if (state is GetAllPaymentLoaded) {
                final List<PaymentEntity>? payments = state.data;

                if (payments == null || payments.isEmpty) {
                  return const Center(child: Text('No payments found'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    final payment = payments[index];
                    return PaymentCard(
                      id: payment.id!,
                      paymentDate: Utility.removeStrip(payment.paymentDate),
                      email:
                          Utility.removeStrip(payment.imageName!.split('_')[0]),
                      createdAt: Utility.timeAgoFormat(payment.createdAt!),
                    );
                  },
                );
              } else if (state is GetAllPaymentLoading) {
                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ShimmerCustomWidget(
                        width: screenWidth * 0.9,
                        height: 70,
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text(state.message!));
              }
            },
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    getAllPaymentCubit.getData();
    _refreshController.refreshCompleted();
  }
}
