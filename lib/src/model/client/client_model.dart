
import 'dart:convert';

List<ClientModel> clientModelFromJson(String str) => List<ClientModel>.from(json.decode(str).map((x) => ClientModel.fromJson(x)));


class ClientModel {
  ClientModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.surname,
    required this.summaUzs,
    required this.summaUsd,
    required this.lastOperationDate,
    required this.comment,
    required this.user,
  });

  int id;
  String name;
  String phone;
  String surname;
  int summaUzs;
  int summaUsd;
  DateTime lastOperationDate;
  String comment;
  int user;

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json["id"]??0,
    name: json["name"]??"",
    phone: json["phone"]??'',
    surname: json["surname"]??'',
    summaUzs: json["summa_uzs"]?? 0,
    summaUsd: json["summa_usd"]??0,
    lastOperationDate: json["last_operation_date"] == null ? DateTime.now():DateTime.parse(json["last_operation_date"]),
    comment: json["comment"]??"",
    user: json["user"]??0,
  );
}
