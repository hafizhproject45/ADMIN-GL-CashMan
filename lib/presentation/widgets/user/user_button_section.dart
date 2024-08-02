import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/toast.dart';
import '../../../domain/entities/auth/user_entity.dart';
import '../../cubit/auth/delete_user/delete_user_cubit.dart';
import '../global/button/my_button_widget.dart';
import '../global/my_dialog_confirmation.dart';

class UserButtonSection extends StatelessWidget {
  const UserButtonSection({
    super.key,
    required this.entity,
  });

  final UserEntity entity;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
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
                'Update user',
                style: AppTextStyle.bodyWhite,
              ),
            ],
          ),
        ),
        BlocConsumer<DeleteUserCubit, DeleteUserState>(
          listener: (context, state) {
            if (state is DeleteUserFailed) {
              dangerToast(msg: state.message);
            } else if (state is DeleteUserSuccess) {
              Get.back(result: 'refresh');
              successToast(msg: 'User deleted successfully');
            }
          },
          builder: (context, state) {
            return MyButtonWidget(
              onPressed: () => _deleteUser(context),
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
                    'Delete user',
                    style: AppTextStyle.bodyWhite,
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  void _deleteUser(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => DialogConfirmation(
        title: 'DELETE USER',
        text: 'Are you sure to delete user "${entity.fullname}"?',
        onClick: () {
          Get.close(1);
          context.read<DeleteUserCubit>().delete(entity.id!, entity.authId!);
        },
      ),
    );
  }
}
