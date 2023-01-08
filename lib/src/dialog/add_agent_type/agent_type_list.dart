import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AgentTypeListDialog{
  static void showAgentTypeListDialog(BuildContext context){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context, builder: (context){
      return StatefulBuilder(builder: (context,setState){
        return Container(
          height: 350,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: ListView.builder(
            itemCount: 5,
              itemBuilder: (context,index){
            return ListTile(
              leading: SvgPicture.asset('assets/icons/profile.svg'),
              onTap: (){
                print('object');
              },
              title: Text('Sharxon '),
              trailing: Radio(value: true
                , groupValue: (){}, onChanged: (value) {  },
              ),
            );
          }),
        );
      });
    });
  }
}