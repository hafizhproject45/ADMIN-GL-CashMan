import 'package:admin_gl_cashman/domain/entities/contact/contact_update_entity.dart';
import 'package:admin_gl_cashman/presentation/cubit/contact/update_contact/update_contact_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/toast.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/contact/post_contact/post_contact_cubit.dart';
import '../../widgets/global/button/my_button_widget.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/text_field_normal/text_field_dropdown_widget.dart';

class AddUpdateContactPage extends StatefulWidget {
  const AddUpdateContactPage({super.key});

  @override
  State<AddUpdateContactPage> createState() => _AddUpdateContactPageState();
}

class _AddUpdateContactPageState extends State<AddUpdateContactPage> {
  final Map<String, dynamic> args = Get.arguments;

  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _positionFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _positionController.dispose();
    _phoneNumberController.dispose();
    _nameFocusNode.dispose();
    _positionFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _nameController.text = args['name'] ?? '';
    _positionController.text = args['position'] ?? '';
    _phoneNumberController.text = args['phone'] ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<PostContactCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<UpdateContactCubit>(),
        ),
      ],
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: MyAppBar(
        title: args['from'],
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
                  MyTextFieldDropdown(
                    name: 'Name',
                    width: MediaQuery.of(context).size.width * 0.85,
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
                  MyTextFieldDropdown(
                    name: 'Position',
                    width: MediaQuery.of(context).size.width * 0.85,
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
                  MyTextFieldDropdown(
                    name: 'Phone Number',
                    width: MediaQuery.of(context).size.width * 0.85,
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
                  args['from'] == 'Update Contact'
                      ? BlocConsumer<UpdateContactCubit, UpdateContactState>(
                          listener: (context, state) {
                            if (state is UpdateContactFailed) {
                              dangerToast(msg: state.message);
                            } else if (state is UpdateContactSuccess) {
                              Get.offNamedUntil(
                                '/contacts',
                                (route) => route.settings.name == '/landing',
                              );
                              successToast(msg: 'Contact Updated Successfully');
                            }
                          },
                          builder: (context, state) {
                            return MyButtonWidget(
                              onPressed: () async {
                                if (state is! UpdateContactLoading) {
                                  _nameFocusNode.unfocus();
                                  _positionFocusNode.unfocus();
                                  _phoneNumberFocusNode.unfocus();
                                  if (_formKey.currentState!.validate()) {
                                    await context
                                        .read<UpdateContactCubit>()
                                        .update(
                                          UpdateContactEntity(
                                            id: args['id'],
                                            name: _nameController.text.trim(),
                                            position:
                                                _positionController.text.trim(),
                                            phone: Utility.convertPhone(
                                                _phoneNumberController.text
                                                    .trim()),
                                            createdAt: args['created_at'],
                                          ),
                                        );
                                  }
                                }
                              },
                              isLoading: state is UpdateContactLoading,
                              width: MediaQuery.of(context).size.width * 0.85,
                              label: 'UPDATE',
                            );
                          },
                        )
                      : BlocConsumer<PostContactCubit, PostContactState>(
                          listener: (context, state) {
                            if (state is PostContactFailed) {
                              dangerToast(msg: state.message);
                            } else if (state is PostContactSuccess) {
                              Get.offNamedUntil(
                                '/contacts',
                                (route) => route.settings.name == '/landing',
                              );
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
                                            name: _nameController.text.trim(),
                                            position:
                                                _positionController.text.trim(),
                                            phone: Utility.convertPhone(
                                              _phoneNumberController.text
                                                  .trim(),
                                            ),
                                          ),
                                        );
                                  }
                                }
                              },
                              isLoading: state is PostContactLoading,
                              width: MediaQuery.of(context).size.width * 0.85,
                              label: 'ADD',
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
