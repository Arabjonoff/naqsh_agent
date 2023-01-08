import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:naqsh_agent/src/dialog/add_expense/add_expense_dialog.dart';
import 'package:naqsh_agent/src/model/income/income_model.dart';
import 'package:naqsh_agent/src/ui/expense/add_expense_screen.dart';

import '../../bloc/expense/expense_bloc.dart';
import '../../dialog/filter/expense/expense_filter.dart';
import '../../theme/app_theme.dart';
import '../../utils/utils.dart';
class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {

  @override
  void initState() {
    _getData();
    expenseBloc.getExpenses(date);
    super.initState();
  }
  @override
  void dispose() {
    expenseBloc.getExpenses(date);
    super.dispose();
  }
  var date = DateFormat('yyyy-MM').format(DateTime.now());
  DateTime selected = DateTime.now();
  List<DateTime> data = [];
  @override
  Widget build(BuildContext context) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Scaffold(
      backgroundColor: AppTheme.expense,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            ExpenseFilterDialog.showExpenseFilterDilaog(context);
          }, icon: SvgPicture.asset('assets/icons/filter.svg')),
        ],
        elevation: 5,
        foregroundColor: AppTheme.black24,
        backgroundColor: AppTheme.white,
        centerTitle: true,
        title: Text('Harajatlar',style: TextStyle(fontSize: 25*w,fontWeight: FontWeight.w700,color: Colors.black),),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.transparent,
            height: 49 * h,
            child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = data[index];
                        date = data[index].toString();
                        expenseBloc.getExpenses(date);
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16 * w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: data[index].month == selected.month &&
                            data[index].year == selected.year
                            ? AppTheme.purple
                            : Colors.white,
                      ),
                      margin: EdgeInsets.only(
                          right: 10, left: 10 * w, bottom: 8 * h),
                      child: Center(
                        child: Text(
                          DateFormat('yyyy-MMMM').format(data[index]),
                          style: TextStyle(
                            fontSize: 16 * h,
                            color: data[index].month == selected.month &&
                                data[index].year == selected.year
                                ? AppTheme.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),

      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<IncomeAllModel>(
              stream: expenseBloc.getExpense,
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  List<Datum> data = snapshot.data!.data;
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context,index){
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 20*h,horizontal: 20*h),
                          margin: EdgeInsets.symmetric(horizontal: 20*w,vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.white,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(4,15),
                                blurRadius: 15,
                                color: Color.fromRGBO(0, 0, 0, 0.1),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              span('Ismi:', data[index].client),
                              span('Hamyon nomi:', data[index].wallet.name),
                              span('Sana:', DateFormat('yyyy-MM-dd').format(data[index].date)),
                              span('Valyuta:', data[index].valyuteType),
                              Row(
                                children: [
                                  Text('Naqd:',style:  TextStyle(fontSize: 18*w,fontWeight: FontWeight.w500,),),
                                  SizedBox(width: 20*w,),
                                  Text(data[index].summaUzs.toString(),style: TextStyle(fontSize: 18*w,fontWeight: FontWeight.w400,color: Colors.green),),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                }
                return const Center(child: CircularProgressIndicator.adaptive(),);
              }
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: FloatingActionButton(onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context){
          return const AddExpenseScreen();
        })),backgroundColor: AppTheme.purple,child: const Icon(Icons.add),),
      ),
    );
  }


  void _getData() {
    DateTime now = DateTime.now();
    var startYear = DateTime(2022,12);
    var endYear = DateTime(now.year,now.month +1); //if you want String
    while (startYear != endYear) {
      data.add(DateTime(startYear.year,startYear.month));
      startYear = DateTime(startYear.year, startYear.month + 1, startYear.day);
    }
  }

  Widget span(String title,content){
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Row(
      children: [
        Padding(
          padding:  EdgeInsets.only(bottom: 8.0*w),
          child: Text(title,style:  TextStyle(fontSize: 18*w,fontWeight: FontWeight.w500,),),
        ),
        SizedBox(width: 20*w,),
        Padding(
          padding:  EdgeInsets.only(bottom: 8.0*w),
          child: Text(content,style: TextStyle(fontSize: 18*w,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.7)),),
        )
      ],
    );
  }

}
