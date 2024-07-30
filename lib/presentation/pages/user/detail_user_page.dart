import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../domain/entities/auth/user_entity.dart';
import '../../../domain/usecases/payment/get_all_payment_usecase.dart';
import '../../../injection_container.dart';
import '../../cubit/auth/delete_user/delete_user_cubit.dart';
import '../../cubit/payment/get_all_payment/get_all_payment_cubit.dart';
import '../../widgets/user/user_history_payment_section.dart';
import '../../widgets/user/user_button_section.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/user/user_date_section.dart';
import '../../widgets/user/user_identity_section.dart';

class DetailUserPage extends StatefulWidget {
  const DetailUserPage({super.key});

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  final getAllPaymentCubit = sl<GetAllPaymentCubit>();

  final UserEntity entity = Get.arguments;

  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getAllPaymentCubit
            ..getData(
              GetAllPaymentParams(userId: entity.id),
            ),
        ),
        BlocProvider(
          create: (context) => sl<DeleteUserCubit>(),
        ),
      ],
      child: _content(screenWidth),
    );
  }

  Widget _content(double screenWidth) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Detail User',
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
            children: [
              //? USER IDENTITY
              UserIdentitySection(entity: entity),
              const SizedBox(height: 20),
              //? USER DATE
              UserDateSection(entity: entity),
              const SizedBox(height: 30),
              //? USER BUTTON
              UserButtonSection(entity: entity),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              //? USER PAYMENT HISTORY
              const UserHistoryPaymentSection()
            ],
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    getAllPaymentCubit.getData(GetAllPaymentParams(userId: entity.id));
    _refreshController.refreshCompleted();
  }
}
