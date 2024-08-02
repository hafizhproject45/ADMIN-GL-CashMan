import 'package:admin_gl_cashman/core/utils/toast.dart';
import 'package:admin_gl_cashman/core/utils/utility.dart';
import 'package:admin_gl_cashman/presentation/cubit/contact/post_contact/post_contact_cubit.dart';
import 'package:admin_gl_cashman/presentation/widgets/global/button/my_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../../injection_container.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/text_field_normal/text_field_normal_widget.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _positionFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _positionController.dispose();
    _nameController.dispose();
    _phoneNumberFocusNode.dispose();
    _positionFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostContactCubit>(),
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Add Contact',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextFieldNormal(
                    name: 'Name',
                    width: 310,
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    nameStyle: AppTextStyle.mediumPrimary,
                    iconz: Icons.person,
                    iconColor: AppColor.primary,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextFieldNormal(
                    name: 'Position',
                    width: 310,
                    focusNode: _positionFocusNode,
                    controller: _positionController,
                    nameStyle: AppTextStyle.mediumPrimary,
                    iconz: Icons.work,
                    iconColor: AppColor.primary,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Position is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextFieldNormal(
                    name: 'Phone Number',
                    width: 310,
                    focusNode: _phoneNumberFocusNode,
                    controller: _phoneNumberController,
                    nameStyle: AppTextStyle.mediumPrimary,
                    type: TextInputType.phone,
                    iconz: Icons.phone,
                    iconColor: AppColor.primary,
                    validator: (value) {
                      String pattern = r'^(?:\+62|0)[0-9]{9,15}$';
                      RegExp regExp = RegExp(pattern);

                      if (value!.isEmpty) {
                        return "Phone Number is required";
                      } else if (!regExp.hasMatch(value)) {
                        return "Phone Number isn't valid";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  BlocConsumer<PostContactCubit, PostContactState>(
                    listener: (context, state) {
                      if (state is PostContactFailed) {
                        dangerToast(msg: state.message);
                      } else if (state is PostContactSuccess) {
                        Get.back(result: 'refresh');
                        successToast(msg: 'Contact Added Successfully');
                      }
                    },
                    builder: (context, state) {
                      return MyButtonWidget(
                        onPressed: () async {
                          if (state is! PostContactLoading) {
                            _nameFocusNode.unfocus();
                            _positionFocusNode.unfocus();
                            _phoneNumberFocusNode.unfocus();
                            if (_formKey.currentState!.validate()) {
                              await context.read<PostContactCubit>().post(
                                    ContactEntity(
                                      name:
                                          '${_nameController.text} (${_positionController.text})',
                                      phone: Utility.convertPhone(
                                        _phoneNumberController.text,
                                      ),
                                    ),
                                  );
                            }
                          }
                        },
                        isLoading: state is PostContactLoading,
                        width: 310,
                        label: 'SAVE',
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
