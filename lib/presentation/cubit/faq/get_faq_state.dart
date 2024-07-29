// ignore_for_file: overridden_fields, annotate_overrides

part of 'get_faq_cubit.dart';

abstract class GetFaqState extends Equatable {
  final String? message;

  const GetFaqState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetFaqInitial extends GetFaqState {
  const GetFaqInitial() : super(null);
}

class GetFaqLoading extends GetFaqState {
  const GetFaqLoading() : super(null);
}

class GetFaqLoaded extends GetFaqState {
  final List<FaqEntity>? data;

  const GetFaqLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

class GetFaqNotLoaded extends GetFaqState {
  final String message;

  const GetFaqNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
