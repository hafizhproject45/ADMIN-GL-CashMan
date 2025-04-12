import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/route_manager.dart';

import '../../../core/utils/toast.dart';
import '../../../core/utils/utility.dart';
import '../../../domain/entities/faq/faq_entity.dart';
import '../../../injection_container.dart';
import '../../cubit/faq/post_faq/post_faq_cubit.dart';
import '../../widgets/global/button/my_button_widget.dart';
import '../../widgets/global/my_app_bar.dart';
import '../../widgets/global/my_rich_text_widget.dart';

class AddFaqPage extends StatefulWidget {
  const AddFaqPage({super.key});

  @override
  State<AddFaqPage> createState() => _AddFaqPageState();
}

class _AddFaqPageState extends State<AddFaqPage> {
  final _questionController = QuillController.basic();
  final _answerController = QuillController.basic();

  @override
  void dispose() {
    _questionController.dispose();
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostFaqCubit>(),
      child: Scaffold(
        appBar: MyAppBar(
          title: 'Add FAQ',
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyRichTextWidget(
                title: 'Question',
                hint: 'Input Question',
                controller: _questionController,
              ),
              const SizedBox(height: 30),
              MyRichTextWidget(
                title: 'Answer',
                hint: 'Input Answer',
                controller: _answerController,
              ),
              const SizedBox(height: 50),
              BlocConsumer<PostFaqCubit, PostFaqState>(
                listener: (context, state) {
                  if (state is PostFaqFailed) {
                    dangerToast(msg: state.message);
                  } else if (state is PostFaqSuccess) {
                    Get.back(result: 'refresh');
                    successToast(msg: 'FAQ added successfully');
                  }
                },
                builder: (context, state) {
                  return MyButtonWidget(
                    label: 'SAVE',
                    width: MediaQuery.of(context).size.width,
                    onPressed: () {
                      // Ambil nilai Delta dari QuillController
                      final questionDelta =
                          _questionController.document.toDelta();
                      final answerDelta = _answerController.document.toDelta();

                      // Periksa jika konten kosong
                      // Validasi konten apakah kosong
                      if (Utility.isFAQEmpty(answerDelta) ||
                          Utility.isFAQEmpty(questionDelta)) {
                        dangerToast(msg: 'Question & Answer field is required');
                        return;
                      }

                      // Konversi Delta menjadi JSON dan hilangkan trailing newlines
                      final questionJson = jsonEncode(
                          _trimTrailingNewlines(questionDelta.toJson()));
                      final answerJson = jsonEncode(
                          _trimTrailingNewlines(answerDelta.toJson()));

                      // Kirim data JSON ke backend atau database
                      // Misalnya menggunakan PostFaqCubit untuk mengirim
                      context.read<PostFaqCubit>().post(
                            FaqEntity(
                              question: questionJson.trim(),
                              answer: answerJson.trim(),
                            ),
                          );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to trim trailing newlines from JSON
  List<dynamic> _trimTrailingNewlines(List<dynamic> deltaJson) {
    final newList = List<dynamic>.from(deltaJson);
    if (newList.isNotEmpty) {
      final lastItem = newList.last;
      if (lastItem is Map<String, dynamic> && lastItem['insert'] == '\n') {
        newList.removeLast();
      }
    }
    return newList;
  }
}
