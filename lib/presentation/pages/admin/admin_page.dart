import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';
import '../../../injection_container.dart';
import '../../cubit/auth/login/login_cubit.dart';
import '../../widgets/global/button/my_button_widget.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/my_dialog_confirmation.dart';
import '../auth/login_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MyAppBar(
        title: 'Administrator',
      ),
      body: Stack(
        children: [
          const Center(
            child: Text('Administrator Page'),
          ),

          //? Button Logout
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Align(
              child: MyButtonWidget(
                buttonColor: Colors.red,
                width: screenWidth * 0.9,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    Text(
                      'Logout',
                      style: AppTextStyle.bodyWhite,
                    ),
                  ],
                ),
                onPressed: () => _onLogout(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => DialogConfirmation(
        title: 'LOGOUT',
        text: 'Are you sure to logout the app?',
        onClick: () {
          Get.close(1);
          sl<LoginCubit>().logout();
          Get.offAll(() => const LoginPage());
        },
      ),
    );
  }
}
