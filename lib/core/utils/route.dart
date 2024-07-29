import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_trans;

import '../../presentation/pages/payment/payments_page.dart';
import '../../presentation/pages/payment/add_payment_page.dart';
import '../../presentation/pages/admin/admin_page.dart';
import '../../presentation/pages/contact/contacts_page.dart';
import '../../presentation/pages/faq/detail_faq_page.dart';
import '../../presentation/pages/faq/faq_page.dart';
import '../../presentation/pages/images/images_page.dart';
import '../../presentation/pages/landing_page.dart';
import '../../presentation/pages/payment/detail_payment_page.dart';
import '../../presentation/pages/user/detail_user_page.dart';
import '../../presentation/pages/user/users_page.dart';

class AppRoute {
  static List<GetPage> get pageRoute => [
        GetPage<LandingPage>(
          name: '/',
          page: () => const LandingPage(),
          transition: get_trans.Transition.fadeIn,
          transitionDuration: const Duration(seconds: 2),
        ),
        GetPage<PaymentsPage>(
          name: '/payments',
          page: () => const PaymentsPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<AddPaymentPage>(
          name: '/payment-add',
          page: () => const AddPaymentPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<DetailPaymentPage>(
          name: '/payment-detail/:id',
          page: () => const DetailPaymentPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<UsersPage>(
          name: '/users',
          page: () => const UsersPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<DetailUserPage>(
          name: '/user-detail/:id',
          page: () => const DetailUserPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<ImageStoragePage>(
          name: '/image-storage',
          page: () => const ImageStoragePage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<AdminPage>(
          name: '/admin',
          page: () => const AdminPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<FaqPage>(
          name: '/faq',
          page: () => const FaqPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<DetailFaqPage>(
          name: '/faq-detail/:id',
          page: () => const DetailFaqPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<ContactsPage>(
          name: '/contact',
          page: () => const ContactsPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<DetailFaqPage>(
          name: '/contact-detail/:id',
          page: () => const DetailFaqPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ];
}
