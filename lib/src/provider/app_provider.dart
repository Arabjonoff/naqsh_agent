import 'dart:convert';

import 'package:naqsh_agent/src/model/http_result.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AppProvider {
  // String baseUrl = "http://192.168.1.141:8088";
  String baseUrl = "http://api.foodaudit.uz";


  static _headers()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token')??"";
    if(token.isNotEmpty){
      return  {
        "Authorization": 'token $token',
        "content-type": "application/json",
      };
    }
    else{
      return  {
        // "Authorization": "token ",
        "content-type": "application/json",
      };
    }

  }

  /// Api requests
  Future<HttpResult> _getRequest(String url) async {
    final dynamic headers = await _headers();
    http.Response response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    return _result(response);
  }

  Future<HttpResult> _postRequest(String url, body) async {
    final dynamic headers = await _headers();
    http.Response response = await http.post(
      Uri.parse(url),
      body: body,
      headers: headers
    );
    return _result(response);
  }

  Future<HttpResult> _deleteRequest(String url,) async {
    final dynamic headers = await _headers();
    http.Response response = await http.delete(
        Uri.parse(url),
        headers: headers
    );
    return _result(response);
  }


  HttpResult _result(http.Response response) {
    print(response.body);
    print(response.statusCode);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return  HttpResult(
        statusCode: response.statusCode,
        isSuccess: true,
        result: json.decode(utf8.decode(response.bodyBytes)),
      );
    } else {
      return HttpResult(
        statusCode: response.statusCode,
        isSuccess: false,
        result: response.body,
      );
    }
  }

  Future<HttpResult> register(String name, surname, phone) async {
    var body = {
      "name": name,
      "surname": surname,
      "phone": phone,
    };
    String url = "$baseUrl/api/register";
    return await _postRequest(url,json.encode(body));
  }

  Future<HttpResult> login(phone) async {
    var body = {
      "phone": phone,
    };
    String url = "$baseUrl/api/auth";
    return await _postRequest(url,json.encode(body));
  }

  Future<HttpResult> activate(phone,code) async {
    var body = {
      "phone": phone,
      "verification_code": code,
    };
    String url = "$baseUrl/api/activate";
    return await _postRequest(url,json.encode(body));
  }
  Future<HttpResult> addWallet(name,valyute,balans,bg) async {
    var body = {
      "name": name,
      "valyute_type": valyute,
      "balans": balans,
      "bg": bg,
    };
    String url = "$baseUrl/api/wallets";
    return await _postRequest(url,json.encode(body));
  }

  Future<HttpResult> getWallet() async {
    String url = "$baseUrl/api/wallets";
    return await _getRequest(url,);
  }
  Future<HttpResult> getWalletDetail(id,date) async {
    String url = "$baseUrl/operations/?operation_type=all&wallet=$id&filter_date=$date";
    return await _getRequest(url,);
  }

  Future<HttpResult> addClients(name,surname,phone,summa_uzs,summa_usd,lastopiration_date,comment,id) async {
    var body = {
      "name": name,
      "surname": surname,
      "phone": phone,
      "summa_uzs": summa_uzs,
      "summa_usd": summa_usd,
      "lastopiration_date": lastopiration_date,
      "comment": comment,
      "category": id,
    };
    String url = "$baseUrl/api/clients";
    return await _postRequest(url,json.encode(body));
  }


  Future<HttpResult> getClient() async {
    String url = "$baseUrl/api/clients";
    return await _getRequest(url,);
  }
  Future<HttpResult> deleteWallet(id) async {
    String url = "$baseUrl/api/wallet/$id/delete";
    return await _deleteRequest(url,);
  }


  Future<HttpResult> addDebt(date,agent,wallet,summa_uzs,summa_usd,lastopiration_date,comment) async {
    var body = {
      "date": date,
      "client": agent,
      "wallet": wallet,
      "summa_uzs": summa_uzs,
      "summa_usd": summa_usd,
      "lastopiration_date": lastopiration_date,
      "comment": comment,
    };
    String url = "$baseUrl/api/clients";
    return await _postRequest(url,json.encode(body));
  }

  Future<HttpResult> addOperation(String type,date, int clientId,walletId,summaUzs,summaUsd,String whichDebt,comment) async {
    var body = {
      "operation_type":type,
      "date": date,
      "client":clientId,
      "wallet":walletId,
      "summa_uzs":summaUzs,
      "summa_usd":summaUsd,
      "which_debt":whichDebt,
      "comment":comment,
    };
    String url = "$baseUrl/operations/";
    return await _postRequest(url,json.encode(body));
  }


  Future<HttpResult> addExpense(date,walletId,summaUzs,summaUsd, cost,comment) async {
    var body = {
      "operation_type":"xarajat",
      "date": date,
      "wallet":walletId,
      "summa_uzs":summaUzs,
      "summa_usd":summaUsd,
      "cost":cost,
      "comment":comment,
    };
    String url = "$baseUrl/operations/";
    return await _postRequest(url,json.encode(body));
  }


  Future<HttpResult> clientId(id) async {
    String url = "$baseUrl/api/client/$id";
    return await _getRequest(url);
  }
  Future<HttpResult> walletAll() async {
    String url = "$baseUrl/api/wallets";
    return await _getRequest(url);
  }
  Future<HttpResult> courseAll() async {
    String url = "$baseUrl/api/rates";
    return await _getRequest(url);
  }
  Future<HttpResult> incomeAll(date,wallet) async {
    String url = "$baseUrl/operations/?operation_type=kirim&filter_date=$date&wallet=$wallet";
    return await _getRequest(url);
  }
  Future<HttpResult> expenseAll(date,) async {
    String url = "$baseUrl/operations?operation_type=xarajat&filter_date=$date";
    return await _getRequest(url);
  }
  Future<HttpResult> debtAll(date,wallet) async {
    String url = "$baseUrl/operations?operation_type=chiqim&filter_date=$date&wallet=$wallet";
    return await _getRequest(url);
  }
  Future<HttpResult> courseAdd(date,course) async {
    var body = {
      "reg_date":date,
      "course":course
    };
    String url = "$baseUrl/api/rates";
    return await _postRequest(url,json.encode(body));
  }

  Future<HttpResult> categoryAdd(name) async {
    var body = {
      "name":name,
    };
    String url = "$baseUrl/api/categories";
    return await _postRequest(url,json.encode(body));
  }

  Future<HttpResult> categoryGet() async {
    String url = "$baseUrl/api/categories";
    return await _getRequest(url);
  }
  Future<HttpResult> categoryDelete(id) async {
    String url = "$baseUrl/category/$id/delete";
    return await _getRequest(url);
  }

  Future<HttpResult> filterDate() async {
    String url = "$baseUrl/api/rates/";
    return await _getRequest(url);
  }
  Future<HttpResult> home() async {
    String url = "$baseUrl/api/home";
    return await _getRequest(url);
  }
  Future<HttpResult> addCost(name) async {
    String url = "$baseUrl/api/costs";
    return await _postRequest(url,json.encode({"name":name}));
  }
  Future<HttpResult> getCost() async {
    String url = "$baseUrl/api/costs";
    return await _getRequest(url);
  }
}
