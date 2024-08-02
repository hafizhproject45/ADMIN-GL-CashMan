class GetSingleUserParams {
  final int userId;
  final String? select;

  GetSingleUserParams({
    required this.userId,
    this.select = '*',
  });
}
