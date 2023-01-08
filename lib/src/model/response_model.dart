class ResponseModel {
  ResponseModel.ResponseModel({
    required this.status,
    required this.statusCode,
    required this.detail,
  });

  String status;
  int statusCode;
  Detail detail;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel.ResponseModel(
    status: json["status"]??"",
    statusCode: json["status_code"]??0,
    detail: json["detail"] == null ?Detail.fromJson({}):Detail.fromJson(json["detail"]),
  );
}

class Detail {
  Detail({
    required this.phone,
  });

  List<String> phone;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
    phone: List<String>.from(json["phone"].map((x) => x)),
  );

}
