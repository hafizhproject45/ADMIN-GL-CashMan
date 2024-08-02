// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/toast.dart';
import '../../../domain/entities/payment/payment_entity.dart';
import '../../../injection_container.dart';
import '../../../core/params/payment/payment_params.dart';
import '../../cubit/payment/payment/payment_cubit.dart';
import '../../widgets/global/button/my_button_widget.dart';
import '../../widgets/global/imagePicker_widget.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/text_field_normal/text_field_normal_widget.dart';

class AddPaymentPage extends StatefulWidget {
  const AddPaymentPage({super.key});

  @override
  State<AddPaymentPage> createState() => _AddPaymentPageState();
}

class _AddPaymentPageState extends State<AddPaymentPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _blockController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _blockFocusNode = FocusNode();
  final FocusNode _dateFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _blockController.dispose();
    _dateController.dispose();
    _nameFocusNode.dispose();
    _blockFocusNode.dispose();
    _dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<PaymentCubit>(),
        ),
      ],
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Add Payment',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  MyTextFieldNormal(
                    name: 'Payer name',
                    width: 310,
                    focusNode: _nameFocusNode,
                    controller: _nameController,
                    nameStyle: AppTextStyle.mediumPrimary,
                    iconz: Icons.person,
                    iconColor: AppColor.primary,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Payment for is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextFieldNormal(
                    name: 'Block',
                    width: 310,
                    focusNode: _blockFocusNode,
                    controller: _blockController,
                    nameStyle: AppTextStyle.mediumPrimary,
                    iconz: Icons.home,
                    iconColor: AppColor.primary,
                    isBlock: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Payment for is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  MyTextFieldNormal(
                    name: 'Payment for',
                    width: 310,
                    focusNode: _dateFocusNode,
                    controller: _dateController,
                    nameStyle: AppTextStyle.mediumPrimary,
                    iconz: Icons.date_range,
                    iconColor: AppColor.primary,
                    isDate: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Payment for is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  const ImagePickerWidget(),
                  const SizedBox(height: 30),
                  BlocConsumer<PaymentCubit, PaymentState>(
                    listener: (context, state) {
                      if (state is PaymentFailed) {
                        dangerToast(msg: state.message);
                      } else if (state is PaymentSuccess) {
                        Get.back(result: 'refresh');
                        successToast(msg: 'Upload completed successfully');
                      }
                    },
                    builder: (context, state) {
                      return MyButtonWidget(
                        label: 'SEND',
                        width: 310,
                        onPressed: () async {
                          if (state is! PaymentLoading) {
                            _nameFocusNode.unfocus();
                            _blockFocusNode.unfocus();
                            _dateFocusNode.unfocus();
                            if (_formKey.currentState!.validate()) {
                              if (selectedImage == null) {
                                return dangerToast(
                                  msg: "Insert a photo first!",
                                );
                              }
                              await context.read<PaymentCubit>().payment(
                                    PaymentParams(
                                      paymentEntity: PaymentEntity(
                                        paymentDate: _dateController.text,
                                      ),
                                      payerName: _nameController.text,
                                      block: _blockController.text,
                                    ),
                                  );
                            }
                          }
                        },
                        isLoading: state is PaymentLoading,
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
