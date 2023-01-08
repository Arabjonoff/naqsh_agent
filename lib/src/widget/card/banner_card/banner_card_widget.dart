import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';

import '../../../utils/utils.dart';

class BannerCardWidget extends StatelessWidget {
  final summa;
  final summa_usd;
  final String name;
  const BannerCardWidget({Key? key, this.summa, required this.name, this.summa_usd}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 5*w),
        height: 80*h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.purple,
        ),
        child: Column(
          children:  [
            Text('$summa uzs',maxLines: 1,style: TextStyle(fontSize: 14*h,fontWeight: FontWeight.w600,color: AppTheme.white),),
            SizedBox(height: 5*h,),
            Text('$summa_usd \$',maxLines: 1,style: TextStyle(fontSize: 14*h,fontWeight: FontWeight.w600,color: AppTheme.white),),
            SizedBox(height: 5*h,),
            Text(name,style: TextStyle(fontSize: 14*h,fontWeight: FontWeight.w400,color: AppTheme.white.withOpacity(0.7),),),
          ],
        ),
      ),
    );
  }
}
