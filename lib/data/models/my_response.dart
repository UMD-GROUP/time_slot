class MyResponse {
  dynamic data;
  String? message;
  int? statusCode;

  MyResponse({this.data, this.message, this.statusCode});

  clear() {
    data = null;
    message = null;
    statusCode = null;
  }
}
