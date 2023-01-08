import 'dart:convert';

import 'package:naqsh_agent/src/model/client/client_model.dart';
import 'package:naqsh_agent/src/model/http_result.dart';
import 'package:naqsh_agent/src/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

class AgentBloc {
  final Repository _repository = Repository();

  final _clientInfo = PublishSubject<List<ClientModel>>();
  Stream<List<ClientModel>> get getClient => _clientInfo.stream;
  
  getClients() async {
    HttpResult response = await _repository.getClient();
    if (response.isSuccess) {
      List<ClientModel> data =
          clientModelFromJson(json.encode(response.result));
      _clientInfo.sink.add(data);
    }
  }
}
final agentBloc = AgentBloc();
