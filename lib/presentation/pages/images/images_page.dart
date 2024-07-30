import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/payment/payment_entity.dart';
import '../../../domain/usecases/payment/get_all_payment_usecase.dart';
import '../../../injection_container.dart';
import '../../cubit/payment/get_all_payment/get_all_payment_cubit.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../widgets/global/my_app_bar.dart';

class ImageStoragePage extends StatefulWidget {
  const ImageStoragePage({super.key});

  @override
  State<ImageStoragePage> createState() => _ImageStoragePageState();
}

class _ImageStoragePageState extends State<ImageStoragePage> {
  final getAllPaymentCubit = sl<GetAllPaymentCubit>();

  final RefreshController _refreshController = RefreshController();
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getAllPaymentCubit..getData(GetAllPaymentParams()),
      child: _content(context),
    );
  }

  Widget _content(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Images'),
      body: SmartRefresher(
        onRefresh: () => _onRefresh(context),
        controller: _refreshController,
        child: SingleChildScrollView(
          child: BlocBuilder<GetAllPaymentCubit, GetAllPaymentState>(
            builder: (context, state) {
              if (state is GetAllPaymentLoaded) {
                final List<PaymentEntity>? payments = state.data;

                if (payments == null || payments.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        'Image is empty',
                        style: AppTextStyle.mediumThin,
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4 / 6,
                  ),
                  itemCount: payments.length,
                  itemBuilder: (context, index) {
                    final payment = payments[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.15),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: payment.imageUrl == null ||
                                    payment.imageUrl!.isNotEmpty
                                ? InkWell(
                                    onTap: () => Get.toNamed(
                                      '/payment-detail/${payment.id}',
                                      arguments: payment,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(10)),
                                      child: Image.network(
                                        payment.imageUrl!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        filterQuality: FilterQuality.high,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return const ShimmerCustomWidget();
                                        },
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    child: Image.network(
                                      Utility.imagePlaceHolder(1000, 1000),
                                      height: 1000,
                                      width: 1000,
                                      fit: BoxFit.cover,
                                      filterQuality: FilterQuality.high,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return const ShimmerCustomWidget(
                                          height: 160,
                                          width: 120,
                                        );
                                      },
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Column(
                              children: [
                                Text(
                                  Utility.removeStrip(payment.paymentDate),
                                  style: AppTextStyle.bodyBoldPrimary,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  Utility.removeStrip(
                                      payment.imageName!.split('_')[0]),
                                  style: AppTextStyle.mediumThin,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is GetAllPaymentLoading) {
                return GridView.builder(
                  padding: const EdgeInsets.all(20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    childAspectRatio: 4 / 6,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return const ShimmerCustomWidget();
                  },
                );
              } else {
                return Center(
                  child: Text(state.message!),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    getAllPaymentCubit.getData(GetAllPaymentParams());
    _refreshController.refreshCompleted();
  }
}
