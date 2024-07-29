import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/images.dart';
import '../../../core/utils/text_style.dart';
import '../../../injection_container.dart';
import '../../cubit/auth/login/login_cubit.dart';
import '../../widgets/global/my_background_image.dart';
import '../../widgets/login/login_form_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LoginCubit>(),
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      body: MyBackgroundImage(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              AppImages.bg,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.logoGL,
                    width: 150,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(height: 30),
                  const LoginFormSection(),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                '© Copyright 2024 by Grand Laswi, Al Right Reserved',
                style: AppTextStyle.small,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
