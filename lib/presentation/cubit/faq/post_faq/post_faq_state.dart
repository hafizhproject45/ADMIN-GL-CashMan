// ignore_for_file: annotate_overrides, overridden_fields

part of 'post_faq_cubit.dart';

abstract class PostFaqState extends Equatable {
  final String? message;

  const PostFaqState({this.message});

  @override
  List<Object?> get props => [message];
}

final class PostFaqInitial extends PostFaqState {}

final class PostFaqLoading extends PostFaqState {}

final class PostFaqSuccess extends PostFaqState {}

final class PostFaqFailed extends PostFaqState {
  final String message;

  const PostFaqFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
