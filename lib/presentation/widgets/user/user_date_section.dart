import 'package:flutter/material.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/auth/user_entity.dart';

class UserDateSection extends StatelessWidget {
  const UserDateSection({
    super.key,
    required this.entity,
  });

  final UserEntity entity;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                entity.createdAt == entity.updatedAt
                    ? Utility.formatDateFromStringToDate(entity.updatedAt!)
                    : '-',
                style: AppTextStyle.bodyBoldPrimary,
              ),
            ],
          )
        ],
      ),
    );
  }
}
