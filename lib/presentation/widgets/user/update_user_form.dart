import 'package:admin_gl_cashman/core/utils/colors.dart';
import 'package:admin_gl_cashman/presentation/widgets/global/text_field_auth/text_field_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/toast.dart';
import '../../../domain/entities/auth/update_user_request_entity.dart';
import '../../../domain/entities/auth/user_entity.dart';
import '../../cubit/auth/update_user/update_user_cubit.dart';
import '../global/button/my_button_widget.dart';
import '../global/text_field_auth/text_field_text_widget.dart';
import '../global/text_field_normal/text_field_dropdown_widget.dart';

class UpdateUserForm extends StatefulWidget {
  final UserEntity entity;

  const UpdateUserForm({
    super.key,
    required this.entity,
  });

  @override
  State<UpdateUserForm> createState() => _UpdateUserFormState();
}

class _UpdateUserFormState extends State<UpdateUserForm> {
  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FocusNode _fullnameFocusNode = FocusNode();
  final FocusNode _blockFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullnameController.dispose();
    _blockController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullnameFocusNode.dispose();
    _blockFocusNode.dispose();
    _phoneFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _fullnameController.text = widget.entity.fullname;
    _blockController.text = widget.entity.block;
    _phoneController.text = widget.entity.phone;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyTextFieldText(
            name: "Fullname",
            iconz: Icons.person,
            textInputAction: TextInputAction.next,
            type: TextInputType.name,
            focusNode: _fullnameFocusNode,
            controller: _fullnameController,
            iconColor: AppColor.primary,
            nameStyle: AppTextStyle.bodyThinBlack,
            width: double.infinity,
            validator: (value) {
              if (value!.isEmpty) {
                return "Fullname is required";
              } else if (value.length > 50) {
                return "Fullname to long";
              }
              return null;
            },
          ),
          MyTextFieldDropdown(
            name: "Block",
            iconz: Icons.home_work_rounded,
            type: TextInputType.streetAddress,
            textInputAction: TextInputAction.next,
            focusNode: _blockFocusNode,
            isBlock: true,
            controller: _blockController,
            iconColor: AppColor.primary,
            nameStyle: AppTextStyle.bodyThinBlack,
            width: double.infinity,
            validator: (value) {
              if (value!.isEmpty) {
                return "Block is required";
              } else if (value.length > 5) {
                return "Block isn't valid";
              }
              return null;
            },
          ),
          MyTextFieldText(
            name: "Phone",
            iconz: Icons.phone_android,
            textInputAction: TextInputAction.next,
            type: TextInputType.phone,
            focusNode: _phoneFocusNode,
            controller: _phoneController,
            iconColor: AppColor.primary,
            nameStyle: AppTextStyle.bodyThinBlack,
            width: double.infinity,
            validator: (value) {
              String pattern = r'^(?:\+62|0)[0-9]{9,15}$';
              RegExp regExp = RegExp(pattern);

              if (value!.isEmpty) {
                return "Phone is required";
              } else if (!regExp.hasMatch(value)) {
                return "Phone isn't valid";
              }
              return null;
            },
          ),
          MyTextFieldText(
            name: "Email",
            iconz: Icons.email,
            textInputAction: TextInputAction.next,
            type: TextInputType.emailAddress,
            focusNode: _emailFocusNode,
            controller: _emailController,
            iconColor: AppColor.primary,
            nameStyle: AppTextStyle.bodyThinBlack,
            width: double.infinity,
            validator: (value) {
              String pattern =
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
              RegExp regex = RegExp(pattern);

              if (value!.isEmpty) {
                return 'Email is required';
              } else if (!regex.hasMatch(value)) {
                return "Email isn't valid";
              }
              return null;
            },
          ),
          MyTextFieldPassword(
            iconz: Icons.lock,
            textInputAction: TextInputAction.next,
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            width: double.infinity,
            validator: (value) {
              if (value!.isEmpty) {
                return "Password is required";
              } else if (value.length < 6) {
                return "Password min 6 characters";
              } else if (value.length >= 30) {
                return "Password maksimal 30 characters";
              }
              return null;
            },
          ),
          MyTextFieldPassword(
            name: "Confirm Password",
            iconz: Icons.lock,
            textInputAction: TextInputAction.send,
            focusNode: _confirmPasswordFocusNode,
            controller: _confirmPasswordController,
            width: double.infinity,
            validator: (value) {
              if (value!.isEmpty) {
                return "Confirm Password is required";
              } else if (value.length < 6) {
                return "Password min 6 characters";
              } else if (_passwordController.text !=
                  _confirmPasswordController.text) {
                return "Password not matches";
              } else if (value.length >= 30) {
                return "Password maksimal 30 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 30),
          BlocConsumer<UpdateUserCubit, UpdateUserState>(
            listener: (context, state) {
              if (state is UpdateUserFailed) {
                dangerToast(msg: state.message);
              } else if (state is UpdateUserSuccess) {
                Get.offNamedUntil(
                  '/users',
                  (route) => route.settings.name == '/landing',
                );
                successToast(msg: 'User updated successfully');
              }
            },
            builder: (context, state) {
              return MyButtonWidget(
                width: MediaQuery.of(context).size.width,
                onPressed: () async {
                  _fullnameFocusNode.unfocus();
                  _blockFocusNode.unfocus();
                  _phoneFocusNode.unfocus();
                  if (_formKey.currentState!.validate()) {
                    await context.read<UpdateUserCubit>().update(
                          UpdateUserRequestEntity(
                            id: widget.entity.id,
                            fullname: _fullnameController.text.trim(),
                            block: _blockController.text.trim(),
                            phone: _phoneController.text.trim(),
                            createdAt: widget.entity.createdAt!,
                          ),
                        );
                  }
                },
                isLoading: state is UpdateUserLoading,
                child: const Text(
                  'Update',
                  style: AppTextStyle.bodyWhite,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
