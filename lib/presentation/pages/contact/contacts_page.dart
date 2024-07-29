import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../widgets/contact/contact_card.dart';
import '../../../core/utils/utility.dart';
import '../../../core/utils/text_style.dart';
import '../../../domain/entities/contact/contact_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/contact/get_contact_cubit.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';

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
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          )
        ],
      ),
      body: SmartRefresher(
        onRefresh: () => _onRefresh(context),
        controller: _refreshController,
        child: SingleChildScrollView(
          child: BlocBuilder<GetContactCubit, GetContactState>(
            builder: (context, state) {
              if (state is GetContactLoaded) {
                final List<ContactEntity>? contacts = state.data;

                if (contacts == null || contacts.isEmpty) {
                  return const Center(
                    child: Text(
                      'Phone not Found',
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
                      id: contact.id!,
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
                return Center(child: Text(state.message!));
              }
            },
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
