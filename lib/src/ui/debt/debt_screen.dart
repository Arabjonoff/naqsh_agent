import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../dialog/add_agent/add_agent_dialog.dart';
import '../../theme/app_theme.dart';
import '../../utils/utils.dart';
import '../../widget/button/ontap_widget.dart';

class DebtScreen extends StatefulWidget {
  const DebtScreen({Key? key}) : super(key: key);

  @override
  State<DebtScreen> createState() => _DebtScreenState();
}

class _DebtScreenState extends State<DebtScreen> {
  @override
  Widget build(BuildContext context) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Scaffold(
      backgroundColor: AppTheme.debt,
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
        foregroundColor: AppTheme.black24,
        backgroundColor: AppTheme.white,
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
        title:const Text('Chiqimlar',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700,color: Colors.black),),
        shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),bottomLeft: Radius.circular(20))
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                }),
          ),
          Container(
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      offset: Offset(-4, 15),
                      blurRadius: 15,
                      color: Color.fromRGBO(0, 0, 0, 0.1)
                  )
                ],
                color: AppTheme.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
            ),
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Umumiy:',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18*h),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('5 235 650.00UZS',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18*h)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 38.0),
        child: FloatingActionButton(onPressed: () =>ShowAddAgentDialog.showAddAgentDialog(context),backgroundColor: AppTheme.purple,child: const Icon(Icons.add),),
      ),
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
