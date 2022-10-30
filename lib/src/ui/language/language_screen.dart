import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/utils.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F4),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset('assets/icons/vvv.svg'),
          ),
          SafeArea(
            child: Padding(
              padding:  EdgeInsets.only(top: 100*h),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Hush kelibsiz !',style: TextStyle(fontSize: 30*h,fontWeight: FontWeight.w700,),),
                    Text('O‘zingizga maqul tilni tanlang !',textAlign: TextAlign.center,style: TextStyle(fontSize: 18*h,height: 2*h),),

                    Card(
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
