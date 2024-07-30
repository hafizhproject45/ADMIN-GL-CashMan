// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_null_comparison
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../domain/entities/auth/user_entity.dart';

class UserCard extends StatelessWidget {
  final UserEntity entity;
  final String name;
  final String block;
  final String email;
  final String createdAt;

  const UserCard({
    super.key,
    required this.entity,
    required this.name,
    required this.block,
    required this.email,
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
            Get.toNamed('/user-detail/${entity.id}', arguments: entity),
        child: ListTile(
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(block),
              const SizedBox(width: 15),
              Container(
                height: 30,
                width: 0.5,
                color: Colors.grey,
              )
            ],
          ),
          title: Text(
            name,
            style: AppTextStyle.bodyBoldPrimary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            email,
            style: AppTextStyle.mediumThin,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Created at',
                style: AppTextStyle.smallThin,
              ),
              Text(
                createdAt,
                style: AppTextStyle.small,
              ),
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
