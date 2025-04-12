// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/auth/user_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/auth/get_all_user/get_all_user_cubit.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../widgets/global/text_field_normal/text_field_dropdown_widget.dart';
import '../../widgets/user/user_card.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userCubit = sl<GetAllUserCubit>();
  final RefreshController _refreshController = RefreshController();

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  Timer? _debounce;
  String? searchText;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _refreshController.dispose();
    _debounce?.cancel();
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
      appBar: MyAppBar(
        title: 'Users',
        leading: IconButton(
          onPressed: () {
            Get.offNamedUntil(
              '/landing',
              (route) => route.settings.name == '/login',
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        action: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: SmartRefresher(
        onRefresh: () => _onRefresh(context),
        controller: _refreshController,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFieldDropdown(
                  name: 'Search',
                  width: double.infinity,
                  focusNode: _searchFocusNode,
                  controller: _searchController,
                  nameStyle: AppTextStyle.mediumPrimary,
                  iconz: Icons.search,
                  iconColor: AppColor.primary,
                  onChanged: (text) {
                    searchText = text;
                    _onSearchChanged(text);
                  },
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
                        child: Text(
                          'User not found!',
                          style: AppTextStyle.mediumThin,
                        ),
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
                          onTap: () async {
                            final result = Get.toNamed(
                                '/user-detail/${user.id}',
                                arguments: user);

                            if (result == 'refresh') {
                              await Future.delayed(const Duration(seconds: 1));
                              _onRefresh(context);
                            }
                          },
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

  void _onSearchChanged(String text) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      userCubit.getData(
        search: text,
      );
    });
  }

  void _onRefresh(BuildContext context) {
    _searchController.clear();
    _searchFocusNode.unfocus;
    userCubit.getData();
    _refreshController.refreshCompleted();
  }
}
