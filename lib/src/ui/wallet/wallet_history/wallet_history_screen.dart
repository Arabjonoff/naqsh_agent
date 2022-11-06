import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqsh_agent/src/widget/button/ontap_widget.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/utils.dart';
import '../../../widget/pop/pop_widget.dart';

class WalletHistoryScreen extends StatefulWidget {
  const WalletHistoryScreen({Key? key}) : super(key: key);

  @override
  State<WalletHistoryScreen> createState() => _WalletHistoryScreenState();
}

class _WalletHistoryScreenState extends State<WalletHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: AppTheme.background,
        child: Column(
          children: [
            SizedBox(height: 60*w,),
            ListTile(
              leading: Radio(value: false, groupValue: true, onChanged: (value) {  },),
              title: Text('Kirimlar'),
            ),
            ListTile(
              leading: Radio(value: false, groupValue: true, onChanged: (value) {  },),
              title: Text('Chiqimlar'),
            ),
            ListTile(
              leading: Radio(value: false, groupValue: true, onChanged: (value) {  },),
              title: Text('Harajatlar'),
            ),
            ListTile(
              leading: Radio(
                activeColor: AppTheme.purple,
                value: true, groupValue: true, onChanged: (value) {  },),
              title: Text('Sana bo‘yicha'),
              trailing: const Icon(Icons.arrow_drop_down,size: 34,),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SfDateRangePicker(
                selectionColor: AppTheme.black24,
              ),
            ),
            const Spacer(),
            OnTapWidget(title: 'Kiritish', onTap: (){}),
            const SizedBox(height: 21,),
            TextButton(onPressed: (){}, child: Text('Barchasini tozalash',style: TextStyle(color: AppTheme.purple,fontSize: 20,fontWeight: FontWeight.w600,),)),
            const SizedBox(height: 32,),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 5,
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.white,
        leading: Padding(
          padding: const EdgeInsets.all(2.0),
          child: NavigatorPop(context),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: SvgPicture.asset('assets/icons/filter.svg'),
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ),
          ),
        ],
        centerTitle: true,
        title:const Text('Hamyonlar tarixi',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black),),
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
      ),
      backgroundColor: AppTheme.background,
      body: ListView.builder(
        itemCount: 6,
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
              span('Ismi:', 'Jorch Burch'),
              span('Hamyon nomi:', 'Plastik USD'),
              span('Sana:', '20.10.2022   20:10'),
              span('Valyuta:', 'USD'),
              Row(
                children: [
                  Text('Naqd:',style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
                  const SizedBox(width: 20,),
                  Text('+\$120',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.green),),
                ],
              )
            ],
          ),
        );
      })
    );
  }
  Widget span(String title,content){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w500,),),
        ),
        const SizedBox(width: 20,),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(content,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.black.withOpacity(0.7)),),
        )
      ],
    );
  }
}
