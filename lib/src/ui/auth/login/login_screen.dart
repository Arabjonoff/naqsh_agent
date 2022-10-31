import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/widget/pop/pop_widget.dart';

import '../../../utils/phone_number_format.dart';
import '../../../utils/utils.dart';
import '../../../widget/button/ontap_widget.dart';

final PhoneNumberTextInputFormatter _phoneNumber =
    PhoneNumberTextInputFormatter();

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                      'Kirish',
                      style: TextStyle(
                        fontSize: 30 * h,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 58.0*w),
                        child: Text(
                          'Quyidagi satrga telefon raqamingizni kiriting ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18 * h,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 20 * w, vertical: 30 * h),
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 4),
                                color: Color.fromRGBO(255, 255, 255, 0.1))
                          ]),
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 54 * w,
                          ),
                          Text(
                            '+998',
                            style: TextStyle(
                              fontSize: 18 * w,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10 * h),
                            height: 22 * h,
                            width: 1,
                            color: Colors.black,
                          ),
                          Expanded(
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                _phoneNumber,
                              ],
                              maxLength: 12,
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontSize: 18 * w),
                              decoration: const InputDecoration(
                                  counterText: '', border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 366 * w,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          ' Hisobimgiz yo‘qmi ?',
                          style: TextStyle(fontSize: 14 * w),
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: Text(
                              ' Ro‘yxatdan o‘ting',
                              style: TextStyle(
                                  color: AppTheme.purple, fontSize: 14 * w,
                              ),
                            ),),
                      ],
                    ),
                    SizedBox(height: 50*w,),
                    OnTapWidget(
                      title: 'Davom etish',
                      onTap: () => Navigator.pushNamed(context, '/verfication'),
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