// ignore_for_file: annotate_overrides, overridden_fields

part of 'post_contact_cubit.dart';

abstract class PostContactState extends Equatable {
  final String? message;

  const PostContactState({this.message});

  @override
  List<Object?> get props => [message];
}

final class PostContactInitial extends PostContactState {}

final class PostContactLoading extends PostContactState {}

final class PostContactSuccess extends PostContactState {}

final class PostContactFailed extends PostContactState {
  final String message;

  const PostContactFailed({required this.message}) : super(message: message);

  @override
  List<Object> get props => [message];
}
