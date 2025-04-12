// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../core/utils/colors.dart';
import '../../../core/utils/text_style.dart';
import '../../../domain/entities/faq/faq_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/faq/get_faq/get_faq_cubit.dart';
import '../../widgets/faq/question_container_widget.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';
import '../../widgets/global/text_field_normal/text_field_dropdown_widget.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final getFaqCubit = sl<GetFaqCubit>();

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
      create: (context) => getFaqCubit..getData(),
      child: _content(),
    );
  }

  Widget _content() {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Frequently Asked Questions',
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
                final result = Get.toNamed('/faq-add');

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
              BlocBuilder<GetFaqCubit, GetFaqState>(
                builder: (context, state) {
                  if (state is GetFaqLoaded) {
                    final List<FaqEntity>? data = state.data;

                    if (data == null || data.isEmpty) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          'FAQ not found!',
                          style: AppTextStyle.mediumThin,
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final faq = data[index];

                        return QuestionContainerWidget(
                          entity: faq,
                          question: faq.question ?? '-',
                          answer: faq.answer ?? '-',
                        );
                      },
                    );
                  } else if (state is GetFaqLoading) {
                    return ListView.builder(
                      padding: const EdgeInsets.all(20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: ShimmerCustomWidget(
                            height: 100,
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
      getFaqCubit.getData(
        search: text,
      );
    });
  }

  void _onRefresh(BuildContext context) {
    getFaqCubit.getData();
    _refreshController.refreshCompleted();
  }
}
