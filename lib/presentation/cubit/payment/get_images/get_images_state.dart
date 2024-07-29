// ignore_for_file: overridden_fields, annotate_overrides

part of 'get_images_cubit.dart';

abstract class GetImagesState extends Equatable {
  final String? message;

  const GetImagesState(this.message);

  @override
  List<Object?> get props => [message];
}

class GetImagesInitial extends GetImagesState {
  const GetImagesInitial() : super(null);
}

class GetImagesLoading extends GetImagesState {
  const GetImagesLoading() : super(null);
}

class GetImagesLoaded extends GetImagesState {
  final List<PaymentEntity>? data;

  const GetImagesLoaded({
    required this.data,
  }) : super(null);

  @override
  List<Object?> get props => [data, message];
}

class GetImagesNotLoaded extends GetImagesState {
  final String message;

  const GetImagesNotLoaded({
    required this.message,
  }) : super(message);

  @override
  List<Object?> get props => [message];
}
