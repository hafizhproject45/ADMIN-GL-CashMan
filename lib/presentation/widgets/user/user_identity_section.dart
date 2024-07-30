import 'package:flutter/material.dart';

import '../../../core/utils/text_style.dart';
import '../../../domain/entities/auth/user_entity.dart';

class UserIdentitySection extends StatelessWidget {
  const UserIdentitySection({
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Fullname',
            style: AppTextStyle.mediumThin,
          ),
          const SizedBox(height: 5),
          Text(
            entity.fullname,
            style: AppTextStyle.bodyBoldPrimary,
          ),
          const SizedBox(height: 20),
          const Text(
            'Block',
            style: AppTextStyle.mediumThin,
          ),
          const SizedBox(height: 5),
          Text(
            entity.block,
            style: AppTextStyle.bodyBoldPrimary,
          ),
          const SizedBox(height: 20),
          const Text(
            'Phone',
            style: AppTextStyle.mediumThin,
          ),
          const SizedBox(height: 5),
          Text(
            entity.phone,
            style: AppTextStyle.bodyBoldPrimary,
          ),
          const SizedBox(height: 20),
          const Text(
            'Email',
            style: AppTextStyle.mediumThin,
          ),
          const SizedBox(height: 5),
          Text(
            entity.email,
            style: AppTextStyle.bodyBoldPrimary,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
