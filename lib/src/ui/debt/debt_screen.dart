import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:naqsh_agent/src/bloc/debt/debt_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../bloc/wallet/wallet_bloc.dart';
import '../../model/income/income_model.dart';
import '../../model/wallet/wallet_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/utils.dart';
import '../../widget/button/ontap_widget.dart';
import '../bottom_menu/bottom_menu_screen.dart';
import '../wallet/wallet_add/add_wallet.dart';

class DebtScreen extends StatefulWidget {
  const DebtScreen({Key? key,}) : super(key: key);

  @override
  State<DebtScreen> createState() => _DebtScreenState();
}

class _DebtScreenState extends State<DebtScreen> {
  @override
  void initState() {
    debtBloc.getDebt(date,'');
    _getData();
    super.initState();
  }
  @override
  void dispose() {
    debtBloc.getDebt(date,'');
    _getData();
    super.dispose();
  }
  var date = DateFormat('yyyy-MM').format(DateTime.now());
  DateTime selected = DateTime.now();
  List<DateTime> data = [];
  num count = 0;
  num countUsd = 0;
  var filterDate;
  var filterWallet;
  @override
  Widget build(BuildContext context) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset('assets/icons/filter.svg'),
              onPressed: () {
                Scaffold.of(context).openEndDrawer();
                walletBloc.getWallet();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        elevation: 5,
        foregroundColor: AppTheme.black24,
        backgroundColor: AppTheme.white,
        centerTitle: true,
        title: Text('Chiqimlar',style: TextStyle(fontSize: 25*w,fontWeight: FontWeight.w700,color: Colors.black),),
        // shape:  const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        // ),
        bottom: PreferredSize(
          preferredSize:  const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.transparent,
            height: 49*h,
            child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = data[index];
                        date = data[index].toString();
                        debtBloc.getDebt(date,'');
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
      endDrawer: Drawer(
        child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Center(
                          child: Text(
                            'Filtr',
                            style: TextStyle(
                                fontSize: 20 * h, fontWeight: FontWeight.w600),
                          )),
                      SizedBox(
                        height: 16 * h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0 * w, vertical: 10 * h),
                        child: Text(
                          'Hamyon boyicha ',
                          style: TextStyle(
                              fontSize: 16 * h, fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: StreamBuilder<List<WalletModel>>(
                            stream: walletBloc.getWalletInfo,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<WalletModel> data = snapshot.data!;
                                return data.isNotEmpty
                                    ? PageView.builder(
                                    itemCount: data.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() =>
                                          filterWallet = data[index].id);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 16 * w),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 16 * w),
                                          height: 100 * h,
                                          width:
                                          MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              border: filterWallet ==
                                                  data[index].id
                                                  ? Border.all(
                                                  color: AppTheme.purple,
                                                  width: 3)
                                                  : Border(),
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: Colors.blue,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: data[index].bg == ""
                                                      ? const AssetImage(
                                                    'assets/icons/006.png',
                                                  )
                                                      : AssetImage(
                                                    data[index].bg,
                                                  ))),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 16 * h,
                                              ),
                                              Text(
                                                data[index].name,
                                                style: TextStyle(
                                                    fontSize: 19 * h,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5 * h,
                                              ),
                                              Text(
                                                'Balans',
                                                style: TextStyle(
                                                    fontSize: 15 * h,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white),
                                              ),
                                              SizedBox(
                                                height: 5 * h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Text(
                                                      data[index]
                                                          .balans
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 21 * h,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: Colors.white)),
                                                  Text(data[index].valyuteType,
                                                      style: TextStyle(
                                                          fontSize: 17 * h,
                                                          fontWeight:
                                                          FontWeight.w500,
                                                          color: Colors.white)),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })
                                    : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20 * w),
                                  width: MediaQuery.of(context).size.width,
                                  height: 100 * h,
                                  decoration: BoxDecoration(
                                    color: AppTheme.purple,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                                  return WalletAddScreen();
                                                }));
                                      },
                                      child: Text(
                                        '+ Hanyon qo\'shish',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0 * w, vertical: 10 * h),
                        child: Text(
                          'Sana boyicha ',
                          style: TextStyle(
                              fontSize: 16 * h, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: SfDateRangePicker(
                          selectionColor: AppTheme.black24,
                          onSelectionChanged:
                              (DateRangePickerSelectionChangedArgs args) {
                            setState(() => filterDate = args.value);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(child: OnTapWidget(title: 'Orqaga', onTap: () =>Navigator.pop(context),color: false,)),
                    Expanded(
                      child: OnTapWidget(
                        title: 'Qollash',
                        onTap: () {
                          debtBloc.getDebt(filterDate, filterWallet);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
      body: StreamBuilder<IncomeAllModel>(
        stream: debtBloc.getIncom,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            List<Datum> data = snapshot.data!.data;
            count = 0;
            for (int i = 0; i < data.length; i++) {
              count += (data[i].summaUzs);
            }
            for (int i = 0; i < data.length; i++) {
              countUsd += (data[i].summaUsd);
            }
            return Column(
              children: [
                Expanded(
                  child:ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20 * h, horizontal: 20 * h),
                          margin:
                          EdgeInsets.symmetric(horizontal: 20 * w, vertical: 10),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppTheme.white,
                            boxShadow: const [
                              BoxShadow(
                                offset: Offset(4, 15),
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
                              span('Valyuta:', data[index].wallet.valyuteType),
                              Row(
                                children: [
                                  Text(
                                    'Naqd:',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20*w,
                                  ),
                                  Text(
                                    priceFormat.format(data[index].summaUzs).toString(),
                                    style: TextStyle(
                                        fontSize: 18*h,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.green),
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      }
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 0.0),
        child: FloatingActionButton(onPressed: () =>Navigator.pushNamed(context, '/add_debt'),backgroundColor: AppTheme.purple,child: const Icon(Icons.add),),
      ),
    );
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
  void _getData() async{
    DateTime now = DateTime.now();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int year = preferences.getInt('year')??now.year;
    int month = preferences.getInt('month')??now.month;
    var startYear = DateTime(year,month);
    var endYear = DateTime(now.year,now.month +1); //if you want String
    while (startYear != endYear) {
      data.add(DateTime(startYear.year,startYear.month));
      startYear = DateTime(startYear.year, startYear.month + 1, startYear.day);
    }
    setState(() {

    });
  }

}

