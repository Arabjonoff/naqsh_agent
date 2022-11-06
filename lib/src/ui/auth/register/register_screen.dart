import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/phone_number_format.dart';
import '../../../utils/utils.dart';
import '../../../widget/button/ontap_widget.dart';
import '../../../widget/pop/pop_widget.dart';



class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  final PhoneNumberTextInputFormatter _phoneNumber =
  PhoneNumberTextInputFormatter();
  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset('assets/icons/vvv.svg',fit: BoxFit.cover),
          ),
          SafeArea(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0 * w,top: 19*h,bottom: 47*w),
                    child: NavigatorPop(context),
                  ),
                  Center(
                      child: Text(
                        'Ro‘yxatdan o‘tish ',
                        style: TextStyle(
                          fontSize: 30 * h,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 58.0*w,vertical: 15*h),
                      child: Text(
                        'Avtorizatsiya qilish uchun quyidagi satrlarga ma’lumotlaringizni kiriting',
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
                        horizontal: 20 * w),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 4),
                              color: Color.fromRGBO(255, 255, 255, 0.1))
                        ]),
                    child: Row(
                      children: [
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal: 15.0*w,vertical: 10),
                     child: SvgPicture.asset('assets/icons/profile.svg',color: const Color(0xFF000000),),
                   ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(fontSize: 18 * w),
                            decoration: const InputDecoration(
                              hintText: 'Ism',
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 20 * w, vertical: 20 * h),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: AppTheme.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              offset: Offset(0, 4),
                              color: Color.fromRGBO(255, 255, 255, 0.1))
                        ]),
                    child: Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 15.0*w,vertical: 10),
                          child: SvgPicture.asset('assets/icons/profile.svg',color: const Color(0xFF000000)),
                        ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(fontSize: 18 * w),
                            decoration: const InputDecoration(
                                hintText: 'Familya',
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 20 * w,),
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
                      Padding(
                        padding:  EdgeInsets.all(15.0*w),
                        child: SvgPicture.asset('assets/icons/call.svg'),
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
                  SizedBox(height: 220*w,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hisobingiz bormi ? ',
                        style: TextStyle(fontSize: 14 * w),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          ' Kirish',
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
          )
        ],
      ),
    );
  }
}
