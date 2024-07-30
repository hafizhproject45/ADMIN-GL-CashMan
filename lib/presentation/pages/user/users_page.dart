import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/auth/user_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/auth/get_all_user/get_all_user_cubit.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/text_field_normal/text_field_normal_widget.dart';
import '../../widgets/user/user_card.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userCubit = sl<GetAllUserCubit>();
  final RefreshController _refreshController = RefreshController();
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => userCubit..getData(),
      child: _content(),
    );
  }

  Widget _content() {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MyAppBar(title: 'Users'),
      body: SmartRefresher(
        onRefresh: () => _onRefresh(context),
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFieldNormal(
                  name: 'Search User',
                  width: double.infinity,
                  // focusNode: _nameFocusNode,
                  // controller: _nameController,
                  nameStyle: AppTextStyle.mediumPrimary,
                  iconz: Icons.search,
                  iconColor: AppColor.primary,
                  isSearch: true,
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<GetAllUserCubit, GetAllUserState>(
                builder: (context, state) {
                  if (state is GetAllUserLoaded) {
                    final List<UserEntity>? users = state.data;

                    if (users == null || users.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text('User is empty'),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return UserCard(
                          entity: user,
                          name: user.fullname,
                          block: user.block,
                          email: user.email,
                          createdAt: Utility.timeAgoFormat(user.createdAt!),
                        );
                      },
                    );
                  } else if (state is GetAllUserLoading) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ShimmerCustomWidget(
                            width: screenWidth * 0.9,
                            height: 70,
                          ),
                        );
                      },
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Text(state.message!),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    userCubit.getData();
    _refreshController.refreshCompleted();
  }
}
