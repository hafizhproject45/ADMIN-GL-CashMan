import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/params/user/get_single_user_params.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/auth/user_entity.dart';
import '../../../domain/entities/payment/payment_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/auth/get_single_user/get_single_user_cubit.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';

class DetailPaymentPage extends StatefulWidget {
  const DetailPaymentPage({super.key});

  @override
  State<DetailPaymentPage> createState() => _DetailPaymentPageState();
}

class _DetailPaymentPageState extends State<DetailPaymentPage> {
  final userCubit = sl<GetSingleUserCubit>();

  final PaymentEntity entity = Get.arguments;

  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => userCubit
        ..getData(
          GetSingleUserParams(
            userId: entity.userId!,
            select: 'fullname, block, phone, email',
          ),
        ),
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Detail Payment',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SmartRefresher(
        onRefresh: () => _onRefresh(context),
        controller: _refreshController,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              entity.imageUrl!.isNotEmpty
                  ? Center(
                      child: InstaImageViewer(
                        imageUrl: entity.imageUrl!,
                        backgroundColor: AppColor.textSmall,
                        disableSwipeToDismiss: true,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColor.textSmall),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Image.network(
                              entity.imageUrl!,
                              height: 160,
                              width: 120,
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
                      ),
                    )
                  : Center(
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColor.textSmall),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(3),
                          child: Image.network(
                            Utility.imagePlaceHolder(120, 160),
                            height: 160,
                            width: 120,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high,
                            loadingBuilder: (BuildContext context, Widget child,
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
                    ),
              const SizedBox(height: 30),
              const Text(
                'Image name',
                style: AppTextStyle.mediumThin,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                entity.imageName!,
                style: AppTextStyle.medium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              const Text(
                'Image size',
                style: AppTextStyle.mediumThin,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Text(
                "${Utility.convertBytesToKilobytes(entity.imageSize!).toStringAsFixed(2)} KB",
                style: AppTextStyle.medium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Payment for',
                          style: AppTextStyle.mediumThin,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          Utility.removeStrip(entity.paymentDate!),
                          style: AppTextStyle.bodyBoldPrimary,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Created at',
                          style: AppTextStyle.mediumThin,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          Utility.formatDateFromStringToDate(entity.createdAt!),
                          style: AppTextStyle.bodyBoldPrimary,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              BlocBuilder<GetSingleUserCubit, GetSingleUserState>(
                builder: (context, state) {
                  if (state is GetSingleUserLoaded) {
                    final UserEntity? user = state.data;

                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.05),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Payer Identity',
                              style: AppTextStyle.subHeading,
                            ),
                          ),
                          user?.fullname == 'ADMIN'
                              ? const Center(
                                  child: Text(
                                    'Pay from Admin',
                                    style: AppTextStyle.mediumThin,
                                  ),
                                )
                              : const SizedBox.shrink(),
                          const SizedBox(height: 30),
                          const Text(
                            'Fullname',
                            style: AppTextStyle.mediumThin,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user?.fullname == 'ADMIN'
                                ? entity.imageName!.split('_')[0].split('-')[0]
                                : user?.fullname ?? '-',
                            style: AppTextStyle.bodyBoldPrimary,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Block',
                            style: AppTextStyle.mediumThin,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user?.block == '-'
                                ? entity.imageName!.split('_')[0].split('-')[1]
                                : user?.block ?? '-',
                            style: AppTextStyle.bodyBoldPrimary,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Phone',
                            style: AppTextStyle.mediumThin,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user?.phone ?? '-',
                            style: AppTextStyle.bodyBoldPrimary,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Email',
                            style: AppTextStyle.mediumThin,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user?.email == 'grandlaswidev@gmail.com'
                                ? '-'
                                : user?.email ?? '-',
                            style: AppTextStyle.bodyBoldPrimary,
                          ),
                        ],
                      ),
                    );
                  } else if (state is GetSingleUserLoading) {
                    return const ShimmerCustomWidget(
                      width: double.infinity,
                      height: 350,
                    );
                  } else {
                    return Center(child: Text(state.message!));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    userCubit.getData(
      GetSingleUserParams(
        userId: entity.userId!,
        select: 'fullname, block, phone, email',
      ),
    );
    _refreshController.refreshCompleted();
  }
}
