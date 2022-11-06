import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/widget/button/ontap_widget.dart';
import 'package:naqsh_agent/src/widget/textfield/textfield_widget.dart';

import '../../utils/utils.dart';

class AddWalletDialog{
  static void showAddWalletDialog(BuildContext context){
    TextEditingController cardController = TextEditingController();
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
        context: context, builder: (context){
      return Container(
        height: 632*h,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
          color: AppTheme.background,
        ),
        child: Column(
          children: [
            Padding(
              padding:  EdgeInsets.all(30.0*h),
              child: Text('Hamyon qo‘shish',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.black),),
            ),
            TextFieldWidget(controller: cardController, icon: 'assets/icons/wallet.svg', hint: 'Karta nomi',),
            TextFieldWidget(controller: cardController, icon: 'assets/icons/coin.svg', hint: 'Valyuta',),
            TextFieldWidget(controller: cardController, icon: 'assets/icons/receipt.svg', hint: 'Qoldiq',),
            const Spacer(),
            OnTapWidget(title: 'Hamyon qo‘shish', onTap: (){}),
            SizedBox(height: 32*w,)
          ],
        ),
      );
    });
  }
}