import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/colors.dart';
import '../../widgets/contact/contact_card.dart';
import '../../../core/utils/utility.dart';
import '../../../core/utils/text_style.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/contact/get_contact_cubit.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../widgets/global/text_field_normal/text_field_normal_widget.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final contactCubit = sl<GetContactCubit>();

  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
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
        action: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              onPressed: () => Get.toNamed('/contact-add'),
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: MyTextFieldNormal(
                  name: 'Search Contact',
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
              BlocBuilder<GetContactCubit, GetContactState>(
                builder: (context, state) {
                  if (state is GetContactLoaded) {
                    final List<ContactEntity>? contacts = state.data;

                    if (contacts == null || contacts.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'Phone is empty',
                          textAlign: TextAlign.center,
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
                          name: contact.name!,
                          phone: contact.phone!,
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

  void _onRefresh(BuildContext context) {
    contactCubit.getData();
    _refreshController.refreshCompleted();
  }
}
