class GetSinglePaymentParams {
  final int userId;
  final String? select;

  GetSinglePaymentParams({
    required this.userId,
    this.select = '*',
  });
}
