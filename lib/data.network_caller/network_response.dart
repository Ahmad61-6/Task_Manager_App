class NetworkResponse {
  final int? statusCode;
  final bool isSuccess;
  final dynamic jsonResponse;
  final String? errorMsg;

  NetworkResponse(
      {this.statusCode = -1,
      required this.isSuccess,
      this.jsonResponse,
      this.errorMsg = 'Something went wrong'});
}
