import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/images.dart';
import '../../core/utils/text_style.dart';
import '../../injection_container.dart';
import '../cubit/payment/get_payment_today/get_payment_today_cubit.dart';
import '../cubit/auth/get_all_user/get_all_user_cubit.dart';
import '../cubit/payment/get_all_payment/get_all_payment_cubit.dart';
import '../widgets/landing_page/analysis_container.dart';
import '../widgets/landing_page/menu_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final userCubit = sl<GetAllUserCubit>();
  final getAllPaymentCubit = sl<GetAllPaymentCubit>();
  final getPaymentTodayCubit = sl<GetPaymentTodayCubit>();

  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => userCubit..getData(),
        ),
        BlocProvider(
          create: (_) => getAllPaymentCubit..getData(),
        ),
        BlocProvider(
          create: (_) => getPaymentTodayCubit..getData(),
        ),
      ],
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      body: SmartRefresher(
        onRefresh: () => _onRefresh(context),
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.bgAdmin),
                fit: BoxFit.cover,
              ),
            ),
            //! ISI
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 300),
                  decoration: BoxDecoration(
                    color: AppColor.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    children: [
                      SizedBox(height: 80),
                      //? Menu Section
                      MenuSection(),
                    ],
                  ),
                ),
                //? Analysis Container
                const AnalysisContainer(),

                //? Logo GL
                Positioned(
                  left: 0,
                  right: 0,
                  top: 70,
                  child: Align(
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.logoGL,
                          height: 100,
                        ),
                        const SizedBox(height: 10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'Admin Panel\n',
                                style: AppTextStyle.body,
                              ),
                              TextSpan(
                                text: 'GL CashMan',
                                style: AppTextStyle.headingWhite,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    userCubit.getData();
    getAllPaymentCubit.getData();
    getPaymentTodayCubit.getData();
    _refreshController.refreshCompleted();
  }
}
