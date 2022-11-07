import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/widget/textfield/textfield_widget.dart';

import '../../utils/utils.dart';

class ShowAddAgentDialog {
  static void showAddAgentDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Container(
            height: 650*h,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.all(30.0*h),
                  child: Text('Kirim qo‘shish',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.black),),
                ),
                TextFieldWidget(controller: controller, icon: 'assets/icons/profile.svg', hint: 'Agent')
              ],
            ),
          );
        });
  }
}
