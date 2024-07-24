import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_trans;

import '../../presentation/pages/payment/main_payment_page.dart';
import '../../presentation/pages/landing_page.dart';
import '../../presentation/pages/user/main_users_page.dart';

class AppRoute {
  static List<GetPage> get pageRoute => [
        GetPage<LandingPage>(
          name: '/',
          page: () => const LandingPage(),
          transition: get_trans.Transition.fadeIn,
          transitionDuration: const Duration(seconds: 2),
        ),
        GetPage<PaymentPage>(
          name: '/payment',
          page: () => const PaymentPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<UsersPage>(
          name: '/users',
          page: () => const UsersPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ];
}
