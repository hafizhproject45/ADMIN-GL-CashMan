import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/toast.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/contact/delete_contact/delete_contact_cubit.dart';
import '../../widgets/global/button/my_button_widget.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/my_dialog_confirmation.dart';

class DetailContactPage extends StatefulWidget {
  const DetailContactPage({super.key});

  @override
  State<DetailContactPage> createState() => _DetailContactPageState();
}

class _DetailContactPageState extends State<DetailContactPage> {
  final ContactEntity entity = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DeleteContactCubit>(),
      child: _content(),
    );
  }

  Widget _content() {
    // final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MyAppBar(
        title: 'Detail Contact',
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
                    'Name',
                    style: AppTextStyle.mediumThin,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    entity.name!.split(' (')[0],
                    style: AppTextStyle.bodyBoldPrimary,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Position',
                    style: AppTextStyle.mediumThin,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    entity.position!,
                    style: AppTextStyle.bodyBoldPrimary,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Phone Number',
                    style: AppTextStyle.mediumThin,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    entity.phone!,
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
                        Utility.formatDateFromStringToDate(entity.createdAt) !=
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
                  onPressed: () {
                    Get.toNamed('/contact-add-update', arguments: {
                      'from': 'Update Contact',
                      'id': entity.id,
                      'name': entity.name,
                      'position': entity.position,
                      'phone': entity.phone,
                      'created_at': entity.createdAt,
                    });
                  },
                  width: 1,
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
                BlocConsumer<DeleteContactCubit, DeleteContactState>(
                  listener: (context, state) {
                    if (state is DeleteContactFailed) {
                      dangerToast(msg: state.message);
                    } else if (state is DeleteContactSuccess) {
                      Get.offNamedUntil(
                        '/contacts',
                        (route) => route.settings.name == '/landing',
                      );
                      successToast(msg: 'Contact deleted successfully');
                    }
                  },
                  builder: (context, state) {
                    return MyButtonWidget(
                      onPressed: () => _deleteContact(context),
                      width: 1,
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
      ),
    );
  }

  void _deleteContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => DialogConfirmation(
        title: 'DELETE CONTACT',
        text: 'Are you sure to delete contact "${entity.name}"?',
        onClick: () {
          Get.close(1);
          context.read<DeleteContactCubit>().delete(entity.id!);
        },
      ),
    );
  }
}
