import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/toast.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/faq/faq_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/faq/delete_faq/delete_faq_cubit.dart';
import '../../widgets/global/button/my_button_widget.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/my_dialog_confirmation.dart';

class DetailFaqPage extends StatefulWidget {
  const DetailFaqPage({super.key});

  @override
  State<DetailFaqPage> createState() => _DetailFaqPageState();
}

class _DetailFaqPageState extends State<DetailFaqPage> {
  final deleteFaq = sl<DeleteFaqCubit>();

  final FaqEntity entity = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocProvider(
      create: (context) => deleteFaq,
      child: _content(screenWidth),
    );
  }

  Widget _content(double screenWidth) {
    return Scaffold(
        appBar: MyAppBar(
          title: 'Detail FAQ',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Question',
                      style: AppTextStyle.mediumThin,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      Utility.decodeFAQ(entity.question!),
                      style: AppTextStyle.bodyBoldPrimary,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Answer',
                      style: AppTextStyle.mediumThin,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      Utility.decodeFAQ(entity.answer!),
                      style: AppTextStyle.bodyBoldPrimary,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text(
                          'Created at',
                          style: AppTextStyle.mediumThin,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          Utility.formatDateFromStringToDate(entity.createdAt!),
                          style: AppTextStyle.bodyBoldPrimary,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text(
                          'Updated at',
                          style: AppTextStyle.mediumThin,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          Utility.formatDateFromStringToDate(
                                      entity.createdAt) !=
                                  Utility.formatDateFromStringToDate(
                                      entity.updatedAt)
                              ? Utility.formatDateFromStringToDate(
                                  entity.updatedAt)
                              : '-',
                          style: AppTextStyle.bodyBoldPrimary,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyButtonWidget(
                    onPressed: () {},
                    width: screenWidth * 0.44,
                    buttonColor: const Color.fromARGB(255, 247, 185, 0),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Update contact',
                          style: AppTextStyle.bodyWhite,
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<DeleteFaqCubit, DeleteFaqState>(
                    listener: (context, state) {
                      if (state is DeleteFaqFailed) {
                        dangerToast(msg: state.message);
                      } else if (state is DeleteFaqSuccess) {
                        Get.offNamedUntil(
                          '/faq',
                          (route) => route.settings.name == '/landing',
                        );
                        successToast(msg: 'Contact deleted successfully');
                      }
                    },
                    builder: (context, state) {
                      return MyButtonWidget(
                        onPressed: () => _deleteContact(context),
                        width: screenWidth * 0.44,
                        buttonColor: Colors.red,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Delete contact',
                              style: AppTextStyle.bodyWhite,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _deleteContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => DialogConfirmation(
        title: 'DELETE FAQ',
        text:
            'Are you sure to delete faq "${Utility.decodeFAQ(entity.question!)}"?',
        onClick: () {
          Get.close(1);
          context.read<DeleteFaqCubit>().delete(entity.id!);
        },
      ),
    );
  }
}
