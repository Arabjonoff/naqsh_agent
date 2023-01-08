import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:naqsh_agent/src/bloc/wallet/wallet_history.dart';


import '../../../model/income/income_model.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/utils.dart';

class WalletHistoryScreen extends StatefulWidget {
  final  id;
  const WalletHistoryScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  @override
  void initState() {
    walletHistoryBloc.getWalletHistory(widget.id,date);
    _getData();
    super.initState();
  }
  var date = DateFormat('yyyy-MM').format(DateTime.now());
  DateTime selected = DateTime.now();
  List<DateTime> data = [];
  @override
  Widget build(BuildContext context) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        foregroundColor: AppTheme.black24,
        backgroundColor: AppTheme.white,
        centerTitle: true,
        title: Text('Hamyonlar tarixi',style: TextStyle(fontSize: 25*w,fontWeight: FontWeight.w700,color: Colors.black),),
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
                        walletHistoryBloc.getWalletHistory(widget.id,date);
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
                          DateFormat('MMMM-yyyy').format(data[index]),
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
      backgroundColor: AppTheme.background,
      body: Column(children: [
        Expanded(
          child: StreamBuilder<IncomeAllModel>(
            stream: walletHistoryBloc.getWallet,
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
                          span('Sana:', data[index].date.toString()),
                          span('Valyuta:', data[index].wallet.valyuteType),
                          if(data[index].wallet.valyuteType == 'sum') Row(
                            children: [
                              Text('Naqd:',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                              const SizedBox(width: 20,),
                              Text(data[index].summaUzs.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.green),),
                            ],
                          )
                          else Row(
                            children: [
                              Text('Naqd:',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                              const SizedBox(width: 20,),
                              Text(data[index].summaUsd.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.green),),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }
            return const Center(child: CircularProgressIndicator.adaptive());
            }
          ),
        ),
      ],),
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
