// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/params/payment/get_all_payment_params.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/payment/payment_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/payment/get_all_payment/get_all_payment_cubit.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../widgets/global/text_field_normal/text_field_dropdown_widget.dart';
import '../../widgets/payment/payment_card.dart';

class PaymentsPage extends StatefulWidget {
  const PaymentsPage({super.key});

  @override
  State<PaymentsPage> createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  final getAllPaymentCubit = sl<GetAllPaymentCubit>();

  final String? date = Get.arguments;

  final RefreshController _refreshController = RefreshController();

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  Timer? _debounce;
  String? searchText;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _refreshController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _searchController.text = date ?? '';
    searchText = date ?? '';
    getAllPaymentCubit.getData(GetAllPaymentParams(), search: searchText);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => getAllPaymentCubit,
      child: _content(screenWidth),
    );
  }

  Widget _content(double screenWidth) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Payments',
        leading: IconButton(
          onPressed: () {
            Get.offNamedUntil(
              '/landing',
              (route) => route.settings.name == '/login',
            );
          },
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
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFieldDropdown(
                  name: 'Search',
                  width: double.infinity,
                  focusNode: _searchFocusNode,
                  controller: _searchController,
                  nameStyle: AppTextStyle.mediumPrimary,
                  iconz: Icons.search,
                  iconColor: AppColor.primary,
                  onChanged: (text) {
                    setState(() {
                      searchText = text;
                    });
                    _onSearchChanged(text);
                  },
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<GetAllPaymentCubit, GetAllPaymentState>(
                builder: (context, state) {
                  if (state is GetAllPaymentLoaded) {
                    final List<PaymentEntity>? payments = state.data;

                    if (payments == null || payments.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'Payment not found!',
                          style: AppTextStyle.mediumThin,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        final payment = payments[index];
                        return PaymentCard(
                          entity: payment,
                          paymentDate:
                              payment.paymentDate!.replaceAll('-', ' | '),
                          email: payment.imageName!
                              .split('_')[0]
                              .replaceAll('-', ' | '),
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
                    return Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(state.message!),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      getAllPaymentCubit.getData(
        GetAllPaymentParams(),
        search: text,
      );
    });
  }

  void _onRefresh(BuildContext context) {
    _searchController.clear();
    _searchFocusNode.unfocus();
    getAllPaymentCubit.getData(GetAllPaymentParams());
    _refreshController.refreshCompleted();
  }
}
