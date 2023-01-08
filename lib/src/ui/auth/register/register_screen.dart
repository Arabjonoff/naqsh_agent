import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqsh_agent/src/model/http_result.dart';
import 'package:naqsh_agent/src/provider/repository.dart';
import 'package:naqsh_agent/src/widget/textfield/textfield_widget.dart';

import '../../../theme/app_theme.dart';
import '../../../utils/phone_number_format.dart';
import '../../../utils/utils.dart';
import '../../../widget/button/ontap_widget.dart';
import '../../../widget/pop/pop_widget.dart';




// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
   RegisterScreen({Key? key}) : super(key: key);
  final PhoneNumberTextInputFormatter _phoneNumber = PhoneNumberTextInputFormatter();
   bool _loading = false;
   TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SvgPicture.asset('assets/icons/vvv.svg',fit: BoxFit.cover),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0 * w,top: 19*h,bottom: 47*h),
                    child: NavigatorPop(context),
                  ),
                  Center(
                      child: Text(
                        'Ro‘yxatdan o‘tish ',
                        style: TextStyle(
                          fontSize: 30 * w,
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
                          fontSize: 18 * w,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  TextFieldWidget(controller: nameController, icon: 'assets/icons/profile.svg', hint: 'Ism'),
                  TextFieldWidget(controller: surnameController, icon: 'assets/icons/profile.svg', hint: 'Familya'),
                  SizedBox(height: 10*h,),
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
                        padding:  EdgeInsets.all(15.0*h),
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
                            // inputFormatters: [
                            //   FilteringTextInputFormatter.digitsOnly,
                            //   _phoneNumber,
                            // ],
                            controller: phoneController,
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
                  SizedBox(height: 220*h,),
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
                  SizedBox(height: 30*h,),
                  OnTapWidget(
                    title: 'Davom etish',
                    onTap: (){
                      if(nameController.text.isNotEmpty&&surnameController.text.isNotEmpty&&phoneController.text.isNotEmpty){
                        senData(nameController.text, surnameController.text, '+998${phoneController.text}',context);
                      }
                      else{
                        final snackBar = SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          behavior: SnackBarBehavior.floating,
                          dismissDirection: DismissDirection.horizontal,
                          content: AwesomeSnackbarContent(
                            title: 'Xatolik',
                            message: "Ko'rsatilgan barcha maydonlarni to'ldiring",
                            contentType: ContentType.failure,
                            inMaterialBanner: false,
                          ),
                        );
                        ScaffoldMessenger.of(context)..hideCurrentMaterialBanner()..showSnackBar(snackBar);
                      }
                    }
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  senData(String name,surname,phone ,context)async{
     Repository _repository = Repository();
    HttpResult response = await _repository.register(name, surname, phone);
    if(response.result["status"] == 'ok'){
      Navigator.pushNamed(context, '/verfication',arguments: phone);
    }
    else{
      final snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        backgroundColor: Colors.transparent,
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.down,
        content: AwesomeSnackbarContent(
          title: 'Xatolik',
          message: 'Bu raqam avval ro\'yhatdan o\'tgan',
          contentType: ContentType.failure,
          inMaterialBanner: false,
        ),
      );
      ScaffoldMessenger.of(context)..hideCurrentMaterialBanner()..showSnackBar(snackBar);
    }

  }
}
