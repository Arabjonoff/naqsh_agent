import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pinput/pinput.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/utils.dart';
import '../../../widget/button/ontap_widget.dart';
import '../../../widget/pop/pop_widget.dart';
final defaultPinTheme = PinTheme(
  width: 50,
  height: 50,
  textStyle: const TextStyle(
    fontSize: 24,
  ),
  decoration: BoxDecoration(
    boxShadow: const [
      BoxShadow(
        color: Color.fromRGBO(255, 255, 255, 0.1),
        offset: Offset(0,4)
      )
    ],
    color: AppTheme.white,
    borderRadius: BorderRadius.circular(10),
  ),
);

class VerficationScreen extends StatelessWidget {
  const VerficationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset('assets/icons/vvv.svg'),
          ),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0 * w, bottom: 47 * h,top: 19*h),
                      child: NavigatorPop(context),
                    ),
                    Center(
                        child: Text(
                          'Tasdiqlash',
                          style: TextStyle(
                            fontSize: 30 * h,
                            fontWeight: FontWeight.w700,
                          ),
                        ),),
                    SizedBox(height: 15*w,),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 58.0*w),
                        child: Text(
                          'Telefon raqamingizga sms kod jo‘natildi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18 * h,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30*w,),
                    Center(
                      child: Pinput(
                        length: 5,
                        defaultPinTheme: defaultPinTheme,
                      ),
                    ),

                    SizedBox(
                      height: 366 * w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Kod kelmadimi ?',
                          style: TextStyle(fontSize: 14 * w),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            ' Qaytadan jo‘natish',
                            style: TextStyle(
                              color: AppTheme.purple, fontSize: 14 * w,
                            ),
                          ),),
                      ],
                    ),
                    SizedBox(height: 50*w,),
                    OnTapWidget(
                      title: 'Davom etish',
                      onTap: () => Navigator.pushNamed(context, '/login'),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
