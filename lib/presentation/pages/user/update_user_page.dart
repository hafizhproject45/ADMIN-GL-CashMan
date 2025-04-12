import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';

import '../../../domain/entities/auth/user_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/auth/update_user/update_user_cubit.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/user/update_user_form.dart';

class UpdateUserPage extends StatelessWidget {
  UpdateUserPage({super.key});

  final UserEntity entity = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<UpdateUserCubit>(),
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Update User',
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: UpdateUserForm(entity: entity),
      ),
    );
  }
}
