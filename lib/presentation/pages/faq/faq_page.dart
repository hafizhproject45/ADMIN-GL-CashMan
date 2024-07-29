import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../domain/entities/faq/faq_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/faq/get_faq_cubit.dart';
import '../../widgets/faq/question_container_widget.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/shimmer/my_shimmer_custom.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  final getFaqCubit = sl<GetFaqCubit>();

  final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    _refreshController.dispose();
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
          child: BlocBuilder<GetFaqCubit, GetFaqState>(
            builder: (context, state) {
              if (state is GetFaqLoaded) {
                final List<FaqEntity>? data = state.data;

                if (data == null || data.isEmpty) {
                  return const Center(
                    child: Text('FAQ not yet created.'),
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
                      id: faq.id!,
                      question: faq.question!,
                      answer: faq.answer!,
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
                return Text(state.message!);
              }
            },
          ),
        ),
      ),
    );
  }

  void _onRefresh(BuildContext context) {
    getFaqCubit.getData();
    _refreshController.refreshCompleted();
  }
}
