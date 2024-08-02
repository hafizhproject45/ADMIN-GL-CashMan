class GetAllPaymentParams {
  final int? userId;
  final String? select;

  GetAllPaymentParams({
    this.userId,
    this.select = '*',
  });
}
