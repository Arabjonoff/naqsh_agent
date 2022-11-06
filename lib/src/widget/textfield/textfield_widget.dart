import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';

import '../../utils/utils.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String icon;
  final String hint;

  const TextFieldWidget(
      {Key? key,
      required this.controller,
      required this.icon,
      required this.hint,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = Utils.getHeight(context);
    double w = Utils.getWidth(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20 * w,vertical: 10),
      width: MediaQuery.of(context).size.width,
      height: 50*w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                blurRadius: 15,
                offset: Offset(4, 15),
                color: Color.fromRGBO(255, 255, 255, 0.1)),
          ],
          color: AppTheme.white),
      child: Row(
        children: [
          SizedBox(width: 20*w,),
          SvgPicture.asset(
            icon,
            height: 24 * h,
            width: 24 * h,
          ),
          SizedBox(width: 10*w,),
          Expanded(
            child: TextField(
              controller: controller,
              decoration:
                  InputDecoration(hintText: hint, border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
