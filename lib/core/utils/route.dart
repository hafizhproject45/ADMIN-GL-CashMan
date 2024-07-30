import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_trans;

import '../../presentation/pages/contact/detail_contact_page.dart';
import '../../presentation/pages/contact/add_contact_page.dart';
import '../../presentation/pages/error/not_found_page.dart';
import '../../presentation/pages/faq/add_faq_page.dart';
import '../../presentation/pages/login/login_page.dart';
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
        GetPage<NotFoundPage>(
          name: '/',
          page: () => const NotFoundPage(),
        ),
        GetPage<LoginPage>(
          name: '/login',
          page: () => const LoginPage(),
          transition: get_trans.Transition.fadeIn,
          transitionDuration: const Duration(seconds: 2),
        ),
        GetPage<LandingPage>(
          name: '/landing',
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
        GetPage<AddFaqPage>(
          name: '/faq-add',
          page: () => const AddFaqPage(),
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
          name: '/contacts',
          page: () => const ContactsPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<AddContactPage>(
          name: '/contact-add',
          page: () => const AddContactPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
        GetPage<DetailContactPage>(
          name: '/contact-detail/:id',
          page: () => const DetailContactPage(),
          transition: get_trans.Transition.topLevel,
          transitionDuration: const Duration(milliseconds: 500),
        ),
      ];
}
