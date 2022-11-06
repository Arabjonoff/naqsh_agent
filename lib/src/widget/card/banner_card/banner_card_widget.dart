import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';

import '../../../utils/utils.dart';

class BannerCardWidget extends StatelessWidget {
  const BannerCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Container(
      height: 80*h,
      width: 115*w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.purple,
      ),
      child: Column(
        children:  [
          SizedBox(height: 15*h,),
          Text('10 230.00 UZS',style: TextStyle(fontSize: 14*h,fontWeight: FontWeight.w600,color: AppTheme.white),),
          SizedBox(height: 15*h,),
          Text('Harajatlar',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400,color: AppTheme.white.withOpacity(0.7),),),
        ],
      ),
    );
  }
}
