import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/colors.dart';
import '../../../domain/entities/auth/user_entity.dart';
import '../../../domain/entities/payment/payment_entity.dart';
import '../../cubit/auth/get_all_user/get_all_user_cubit.dart';
import '../../cubit/payment/get_all_payment/get_all_payment_cubit.dart';
import '../../cubit/payment/get_payment_today/get_payment_today_cubit.dart';
import '../global/shimmer/my_shimmer_custom.dart';
import 'analysis_field.dart';

class AnalysisContainer extends StatelessWidget {
  const AnalysisContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: 0,
      right: 0,
      top: 260,
      child: Align(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 80,
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColor.white,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 10),
                color: Color.fromARGB(5, 0, 0, 0),
                spreadRadius: 5,
                blurRadius: 50,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BlocBuilder<GetAllPaymentCubit, GetAllPaymentState>(
                builder: (context, state) {
                  if (state is GetAllPaymentLoaded) {
                    final List<PaymentEntity>? payment = state.data;

                    return AnalysisField(
                      title: 'Total Payment',
                      value: '${payment?.length ?? 0}',
                      iconz: Icons.payment,
                      route: '/payments',
                    );
                  } else if (state is GetAllPaymentLoading) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerCustomWidget(
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ShimmerCustomWidget(
                          width: 85,
                          height: 20,
                        ),
                      ],
                    );
                  } else {
                    return Text(state.message!);
                  }
                },
              ),
              Container(
                height: 50,
                width: 0.5,
                color: Colors.grey.shade500,
              ),
              BlocBuilder<GetPaymentTodayCubit, GetPaymentTodayState>(
                builder: (context, state) {
                  if (state is GetPaymentTodayLoaded) {
                    final List<PaymentEntity>? payment = state.data;

                    return AnalysisField(
                      title: 'Payment Today',
                      value: '${payment?.length ?? 0}',
                      iconz: Icons.today,
                      route: '/payments',
                    );
                  } else if (state is GetPaymentTodayLoading) {
                    return const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerCustomWidget(
                          width: 30,
                          height: 30,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ShimmerCustomWidget(
                          width: 85,
                          height: 20,
                        ),
                      ],
                    );
                  } else {
                    return Text(state.message!);
                  }
                },
              ),
              Container(
                height: 50,
                width: 0.5,
                color: Colors.grey.shade500,
              ),
              BlocBuilder<GetAllUserCubit, GetAllUserState>(
                builder: (context, state) {
                  if (state is GetAllUserLoaded) {
                    final List<UserEntity>? user = state.data;

                    return AnalysisField(
                      title: 'Total User',
                      value: '${user?.length ?? 0}',
                      iconz: Icons.person,
                      padding: 10,
                      route: '/users',
                    );
                  } else if (state is GetAllUserLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ShimmerCustomWidget(
                            width: 30,
                            height: 30,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          ShimmerCustomWidget(
                            width: 60,
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Text(state.message!);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
