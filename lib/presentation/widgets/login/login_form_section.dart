import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/toast.dart';
import '../../cubit/auth/login/login_cubit.dart';
import '../global/button/my_button_widget.dart';
import '../global/text_field_auth/text_field_password_widget.dart';
import '../global/text_field_auth/text_field_text_widget.dart';

class LoginFormSection extends StatefulWidget {
  const LoginFormSection({super.key});

  @override
  State<LoginFormSection> createState() => _LoginFormSectionState();
}

class _LoginFormSectionState extends State<LoginFormSection> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Form(
      key: _formKey,
      child: SizedBox(
        width: screenWidth * 0.93,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'LOGIN',
              style: AppTextStyle.headingWhite,
            ),
            const SizedBox(height: 40),
            MyTextFieldText(
              name: "Email",
              type: TextInputType.emailAddress,
              iconz: Icons.email,
              focusNode: _emailFocusNode,
              controller: _emailController,
              textInputAction: TextInputAction.next,
              width: screenWidth * 0.85,
              validator: (value) {
                String pattern =
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                RegExp regex = RegExp(pattern);

                if (value!.isEmpty) {
                  return 'Email tidak boleh kosong';
                } else if (!regex.hasMatch(value)) {
                  return 'Email tidak valid';
                }
                return null;
              },
            ),
            MyTextFieldPassword(
              textInputAction: TextInputAction.send,
              iconz: Icons.lock,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              width: screenWidth * 0.85,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Password tidak boleh kosong";
                }
                return null;
              },
            ),
            const SizedBox(height: 30),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginFailed) {
                  dangerToast(
                    msg: state.message,
                  );
                } else if (state is LoginLoggedIn) {
                  Get.offAllNamed('/landing');
                }
              },
              builder: (context, state) {
                return MyButtonWidget(
                  label: 'LOGIN',
                  width: screenWidth * 0.85,
                  onPressed: () {
                    _emailController.text = 'grandlaswidev@gmail.com';
                    _passwordController.text = 'Admin123';

                    if (state is! LoginLoading) {
                      _emailFocusNode.unfocus();
                      _passwordFocusNode.unfocus();
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        context.read<LoginCubit>().login(
                              _emailController.text,
                              _passwordController.text,
                            );
                      }
                    }
                  },
                  isLoading: state is LoginLoading,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
