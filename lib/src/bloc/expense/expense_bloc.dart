import 'package:naqsh_agent/src/model/income/income_model.dart';
import 'package:naqsh_agent/src/provider/repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../model/http_result.dart';

class ExpenseBloc{
  Repository _repository = Repository();

  final _fetchIncome = PublishSubject<IncomeAllModel>();
  Stream<IncomeAllModel> get getExpense => _fetchIncome.stream;


  getExpenses(date)async{
    HttpResult response = await _repository.expenseAll(date);
    if(response.isSuccess){
      IncomeAllModel data = IncomeAllModel.fromJson(response.result);
      _fetchIncome.sink.add(data);
    }
  }
}

final expenseBloc = ExpenseBloc();