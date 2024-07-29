// import 'package:flutter/material.dart';
// import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

// import '../../../core/utils/colors.dart';
// import '../../pages/payment/add_payment_page.dart';
// import '../../pages/payment/payments_page.dart';
// import '../global/my_navbar.dart';

// class PaymentNavbar extends StatefulWidget {
//   const PaymentNavbar({super.key});

//   @override
//   State<PaymentNavbar> createState() => _PaymentNavbarState();
// }

// class _PaymentNavbarState extends State<PaymentNavbar> {
//   @override
//   Widget build(BuildContext context) {
//     return MyNavigationBar(
//       screens: const [
//         PaymentsPage(),
//         AddPaymentPage(),
//       ],
//       tab: [
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.history),
//           title: ("History"),
//           activeColorPrimary: AppColor.primary,
//           inactiveColorPrimary: AppColor.textSmall,
//         ),
//         PersistentBottomNavBarItem(
//           icon: const Icon(Icons.payment),
//           title: ("Payment"),
//           activeColorPrimary: AppColor.primary,
//           inactiveColorPrimary: AppColor.textSmall,
//         ),
//       ],
//     );
//   }
// }
