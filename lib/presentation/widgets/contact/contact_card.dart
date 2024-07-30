// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../domain/entities/contact/contact_entity.dart';

class ContactCard extends StatelessWidget {
  final ContactEntity entity;
  final String name;
  final String phone;
  final String createdAt;

  const ContactCard({
    super.key,
    required this.entity,
    required this.name,
    required this.phone,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: InkWell(
        onTap: () =>
            Get.toNamed('/contact-detail/${entity.id}', arguments: entity),
        child: ListTile(
          title: Text(
            name,
            style: AppTextStyle.bodyBoldPrimary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            phone,
            style: AppTextStyle.mediumThin,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text('Created at', style: AppTextStyle.smallThin),
              Text(createdAt, style: AppTextStyle.small),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerOfField extends StatelessWidget {
  const ContainerOfField({
    super.key,
    required this.title,
    required this.field,
  });

  final String title;
  final String field;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColor.textSmall,
          ),
          borderRadius: BorderRadius.circular(5)),
      child: Column(children: [
        Text(
          title,
          style: AppTextStyle.bodyBoldPrimary,
        ),
        const SizedBox(height: 5),
        Text(
          field,
          style: AppTextStyle.medium,
        ),
      ]),
    );
  }
}
