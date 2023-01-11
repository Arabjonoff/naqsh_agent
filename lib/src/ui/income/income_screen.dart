import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:naqsh_agent/src/bloc/income/income_bloc.dart';
import 'package:naqsh_agent/src/model/income/income_model.dart';
import 'package:naqsh_agent/src/widget/button/ontap_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../bloc/wallet/wallet_bloc.dart';
import '../../model/wallet/wallet_model.dart';
import '../../theme/app_theme.dart';
import '../../utils/utils.dart';
import '../bottom_menu/bottom_menu_screen.dart';
import '../wallet/wallet_add/add_wallet.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  void initState() {
    incomeBloc.getIncome(date, '');
    _getData();
    super.initState();
  }

  var date = DateFormat('yyyy-MM').format(DateTime.now());
  var filterDate;
  var filterWallet;
  DateTime selected = DateTime.now();
  List<DateTime> listDate = [];


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
        title: const Text(
          'Kirimlar',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w700, color: Colors.black),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.transparent,
            height: 49 * h,
            child: ListView.builder(
                itemCount: listDate.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selected = listDate[index];
                        date = listDate[index].toString();
                        incomeBloc.getIncome(date, '');
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16 * w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: listDate[index].month == selected.month &&
                                listDate[index].year == selected.year
                            ? AppTheme.purple
                            : Colors.white,
                      ),
                      margin: EdgeInsets.only(
                          right: 10, left: 10 * w, bottom: 8 * h),
                      child: Center(
                        child: Text(
                          DateFormat('yyyy-MMMM').format(listDate[index]),
                          style: TextStyle(
                            fontSize: 16 * h,
                            color: listDate[index].month == selected.month &&
                                    listDate[index].year == selected.year
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
        // shape: const RoundedRectangleBorder(
        //     borderRadius: BorderRadius.only(
        //         bottomRight: Radius.circular(20),
        //         bottomLeft: Radius.circular(20))),
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
                      incomeBloc.getIncome(filterDate, filterWallet);
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
          stream: incomeBloc.getIncom,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Datum> data = snapshot.data!.data;
              int count = 0;
              for (int i = 0; i < data.length; i++) {
                count += (data[i].summaUzs);
              }
              int countUsd = 0;
              for (int i = 0; i < data.length; i++) {
                countUsd += (data[i].summaUsd);
              }
              return snapshot.data!.data.isEmpty
                  ? Center(
                      child: Text('Joriy oy uchun ma\'lumotlar topilmadi'),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20 * h, horizontal: 20 * h),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20 * w, vertical: 10),
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
                                      span('Hamyon nomi:',
                                          data[index].wallet.name),
                                      span(
                                          'Sana:',
                                          DateFormat('yyyy-MM-dd')
                                              .format(data[index].date)),
                                      span('Valyuta:',
                                          data[index].wallet.valyuteType),
                                      span('Izoh:', data[index].comment),
                                      Row(
                                        children: [
                                          Text(
                                            'Sum:',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20 * w,
                                          ),
                                          Text(
                                            priceFormat.format(data[index].summaUzs).toString(),
                                            style: TextStyle(
                                                fontSize: 18 * h,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8 * h,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Dollar:',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 20 * w,
                                          ),
                                          Text(
                                            priceFormat.format(data[index].summaUsd).toString(),
                                            style: TextStyle(
                                                fontSize: 18 * h,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20 * w),
                          width: MediaQuery.of(context).size.width,
                          height: 90 * h,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Umumiy balans:',
                                style: TextStyle(fontSize: 18 * h),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('${priceFormat.format(count)} som',
                                      style: TextStyle(fontSize: 18 * h)),
                                  SizedBox(
                                    height: 5 * h,
                                  ),
                                  Text('${priceFormat.format(countUsd)} \$',
                                      style: TextStyle(fontSize: 18 * h)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    );
            }
            return const Center(child: CircularProgressIndicator.adaptive());
          }),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 55.0 * h),
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, '/add_income'),
          backgroundColor: AppTheme.purple,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  void _getData() async {
    DateTime now = DateTime.now();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int year = preferences.getInt('year') ?? now.year;
    int month = preferences.getInt('month') ?? now.month;
    var startYear = DateTime(year, month);
    var endYear = DateTime(now.year, now.month + 1); //if you want String
    while (startYear != endYear) {
      listDate.add(DateTime(startYear.year, startYear.month));
      startYear = DateTime(startYear.year, startYear.month + 1, startYear.day);
    }
    setState(() {});
  }

  Widget span(String title, content) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0 * w),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18 * w,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          width: 20 * w,
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 8.0 * w),
          child: Text(
            content,
            style: TextStyle(
                fontSize: 18 * w,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.7)),
          ),
        )
      ],
    );
  }
}
