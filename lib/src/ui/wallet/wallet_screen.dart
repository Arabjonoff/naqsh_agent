import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/dialog/add_wallet/add_wallet_dialog.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/widget/button/ontap_widget.dart';
import 'package:naqsh_agent/src/widget/card/wallet_card/wallet_card_widget.dart';
import 'package:naqsh_agent/src/widget/pop/pop_widget.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.white,
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: NavigatorPop(context),
        ),
        centerTitle: true,
        title:const Text('Hamyonlar',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.black),),
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
      ),
      backgroundColor: AppTheme.background,
      body: Column(
        children: [
          Expanded(child: Column(
            children: [
              SizedBox(height: 20,),
              WalletCardWidget(onTap: ()=>Navigator.pushNamed(context, '/wallet_history'),),
              WalletCardWidget(onTap: () {  },),
              WalletCardWidget(onTap: () {  },),
            ],
          ),),
          OnTapWidget(title: 'Hamyon qo‘shish', onTap: (){
            AddWalletDialog.showAddWalletDialog(context);
          }),
          SizedBox(height: 32,)
        ],
      ),
    );
  }
}
