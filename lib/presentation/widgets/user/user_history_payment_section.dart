import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/payment/payment_entity.dart';
import '../../cubit/payment/get_all_payment/get_all_payment_cubit.dart';
import '../global/shimmer/my_shimmer_custom.dart';
import '../payment/payment_card.dart';

class UserHistoryPaymentSection extends StatefulWidget {
  const UserHistoryPaymentSection({super.key});

  @override
  State<UserHistoryPaymentSection> createState() =>
      _UserHistoryPaymentSectionState();
}

class _UserHistoryPaymentSectionState extends State<UserHistoryPaymentSection> {
  int paymentCount = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'History Payments',
              style: AppTextStyle.subHeading,
            ),
            Text(
              'Total: $paymentCount',
              style: AppTextStyle.mediumThin,
            )
          ],
        ),
        const SizedBox(height: 20),
        BlocBuilder<GetAllPaymentCubit, GetAllPaymentState>(
          builder: (context, state) {
            if (state is GetAllPaymentLoaded) {
              final List<PaymentEntity>? payments = state.data;

              if (payments == null || payments.isEmpty) {
                // Mengatur ulang paymentCount jika tidak ada pembayaran
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      paymentCount = 0;
                    });
                  }
                });

                return const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Text('No History Payments'),
                  ),
                );
              }

              // Mengatur paymentCount ke jumlah pembayaran yang ada
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    paymentCount = payments.length;
                  });
                }
              });

              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: payments.length,
                itemBuilder: (context, index) {
                  final payment = payments[index];

                  return PaymentCard(
                    entity: payment,
                    paymentDate: Utility.removeStrip(payment.paymentDate),
                    email:
                        Utility.removeStrip(payment.imageName!.split('_')[0]),
                    createdAt: Utility.timeAgoFormat(payment.createdAt!),
                  );
                },
              );
            } else if (state is GetAllPaymentLoading) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
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
              return Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(child: Text(state.message!)),
              );
            }
          },
        ),
      ],
    );
  }
}
