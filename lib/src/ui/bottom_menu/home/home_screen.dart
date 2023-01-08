import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqsh_agent/src/model/wallet/wallet.dart';
import 'package:naqsh_agent/src/model/wallet/wallet_model.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/widget/stack/stack_widget.dart';
import '../../../bloc/wallet/wallet_bloc.dart';
import '../../../model/http_result.dart';
import '../../../provider/repository.dart';
import '../../../utils/utils.dart';
import '../../wallet/wallet_add/add_wallet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    walletBloc.getWallet();
    sum();
  }
  @override
  void dispose() {
    super.dispose();
    walletBloc.getWallet();
  }
  GlobalKey _one = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Scaffold(
        backgroundColor: AppTheme.background,
        body: SafeArea(
          child: RefreshIndicator(
            onRefresh: ()async{
              await Future.delayed(Duration(seconds: 2));
              walletBloc.getWallet();
              sum();
            },
            child: Stack(
              children: [
                SvgPicture.asset('assets/icons/vvv.svg',fit: BoxFit.cover,),
                SingleChildScrollView(
                  child: Column(
                    children:  [
                       SizedBox(height: 32*h,),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: StreamBuilder<List<WalletModel>>(
                            stream: walletBloc.getWalletInfo,
                            builder: (context, snapshot) {
                            if(snapshot.hasData){
                              List<WalletModel> data = snapshot.data!;
                              for(int i = 0;i<data.length;i++){
                              }
                              return  data.isNotEmpty? PageView.builder(
                                  itemCount: data.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context,index){
                                    return GestureDetector(
                                      onTap: (){
                                        Navigator.pushNamed(context, '/wallet_history',arguments: data[index].id);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 16*w),
                                        margin: EdgeInsets.symmetric(horizontal: 16*w),
                                        height: 100*h,
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.blue,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: data[index].bg == ""?const AssetImage(
                                                'assets/icons/006.png',
                                              ):AssetImage(
                                                data[index].bg,
                                              )
                                          )
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 16*h,),
                                            Text(data[index].name,style: TextStyle(fontSize: 19*h,fontWeight: FontWeight.w700,color: Colors.white),),
                                            SizedBox(height: 5*h,),
                                            Text('Balans',style: TextStyle(fontSize: 15*h,fontWeight: FontWeight.w400,color: Colors.white),),
                                            SizedBox(height: 5*h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(data[index].balans.toString(),style: TextStyle(fontSize: 21*h,fontWeight: FontWeight.w700,color: Colors.white)),
                                                Text(data[index].valyuteType,style: TextStyle(fontSize: 17*h,fontWeight: FontWeight.w500,color: Colors.white)),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }):
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20*w),
                                width: MediaQuery.of(context).size.width,
                                height: 100*h,
                                decoration: BoxDecoration(
                                  color: AppTheme.purple,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Center(
                                  child: TextButton(
                                    onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return WalletAddScreen();
                                      }));
                                    },
                                    child: Text('+ Hanyon qo\'shish',style: TextStyle(color: Colors.white),),
                                  ),
                                ),
                              );
                            }return const Center(child: CircularProgressIndicator.adaptive(),);
                          }
                        ),
                      ),
                      const SizedBox(height: 32,),
                       StackWidget(income: income, debt: debt, expense: cost, incomeUsd: incomeUsd, debtUsd: debtUsd, expenseUsd: costUsd,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),);
  }
  void sum()async{
    HttpResult res = await Repository().home();
    income = res.result['data']['kirim'];
    debt = res.result['data']['chiqim'];
    cost = res.result['data']['xarajat'];
    incomeUsd = res.result['data']['kirim_usd'];
    debtUsd = res.result['data']['chiqim_usd'];
    costUsd = res.result['data']['xarajat_usd'];
    setState(() {});
  }
  num income = 0;
  num debt = 0;
  num cost = 0;
  num incomeUsd = 0;
  num debtUsd = 0;
  num costUsd = 0;
}
