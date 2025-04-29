class ApiResponse<T> {
  bool status;
  String message;
  String statusCode;
  T? data;

  ApiResponse(
      {required this.status, required this.statusCode, required this.message,  this.data});

  factory ApiResponse.fromJson(
      Map<String, dynamic> json, Function(Map<String, dynamic>) create) {
    return ApiResponse<T>(
      status: json["status"],
      statusCode: json["statusCode"],
      message: json["message"],
      data: create(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "status": this.status,
        "statusCode": this.statusCode,
        "message": this.message,
        "data": this.data != null ? this.data!.toString() : null,
      };
}

abstract class Serializable {
  Map<String, dynamic> toJson();
}
