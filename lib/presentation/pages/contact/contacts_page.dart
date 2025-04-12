// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/contact/get_contact/get_contact_cubit.dart';
import '../../widgets/contact/contact_card.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../widgets/global/text_field_normal/text_field_dropdown_widget.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final contactCubit = sl<GetContactCubit>();

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
      create: (context) => contactCubit..getData(),
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Contacts',
        leading: IconButton(
          onPressed: () {
            Get.offNamedUntil(
              '/landing',
              (route) => route.settings.name == '/login',
            );
          },
          icon: const Icon(Icons.arrow_back),
        ),
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () async {
                final result = Get.toNamed('/contact-add-update',
                    arguments: {'from': 'Add Contact'});
                if (result == 'refresh') {
                  await Future.delayed(const Duration(seconds: 1));
                  _onRefresh(context);
                }
              },
              icon: const Icon(Icons.add),
            ),
          )
        ],
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
              BlocBuilder<GetContactCubit, GetContactState>(
                builder: (context, state) {
                  if (state is GetContactLoaded) {
                    final List<ContactEntity>? contacts = state.data;

                    if (contacts == null || contacts.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'Phone not found!',
                          style: AppTextStyle.mediumThin,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      itemCount: contacts.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final contact = contacts[index];

                        return ContactCard(
                          entity: contact,
                          name: '${contact.name}(${contact.position})',
                          phone: contact.phone ?? '-',
                          createdAt: Utility.timeAgoFormat(contact.createdAt!),
                        );
                      },
                    );
                  } else if (state is GetContactLoading) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ShimmerCustomWidget(
                            height: 70,
                            width: double.infinity,
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
      contactCubit.getData(
        search: text,
      );
    });
  }

  void _onRefresh(BuildContext context) {
    contactCubit.getData();
    _refreshController.refreshCompleted();
  }
}
