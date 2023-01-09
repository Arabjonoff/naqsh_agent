// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naqsh_agent/src/dialog/alert/alert_dialog.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dialog/lang/lang_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    img();
  }

  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        elevation: 5,
        foregroundColor: AppTheme.black24,
        backgroundColor: AppTheme.white,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  backgroundImage();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 150 * h,
                  color: AppTheme.purple,
                  child: bgImages != ''
                      ? Image.asset(
                          bgImages,
                          fit: BoxFit.cover,
                        )
                      : bgImage != null
                          ? Image.file(
                              bgImage!,
                              fit: BoxFit.cover,
                            )
                          : const Icon(Icons.add_a_photo_outlined),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 65 * h),
                    child: GestureDetector(
                      onTap: () {
                        pickImage();
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10 * h, left: 16 * w),
                        height: 70 * h,
                        width: 70 * h,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: images != ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  images,
                                  fit: BoxFit.cover,
                                ))
                            : image != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.file(
                                      image!,
                                      fit: BoxFit.cover,
                                    ))
                                : const Icon(Icons.add_a_photo_outlined),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 65 * h, right: 16 * w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Jasur',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20 * h,
                              color: Colors.white),
                        ),
                        Text(
                          '+998914980168',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 20 * h,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
          SizedBox(height: 50*h,),
          ListTile(
            leading: Icon(
              Icons.language,
              color: AppTheme.purple,
            ),
            onTap: () {
              ShowBottomLanguageDialog.showLangDialog(context);
            },
            title: Text('Tilni ozgartirish'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.purple,
            ),
          ),
          ListTile(
            leading: Icon(Icons.list_alt_rounded),
            onTap: () {},
            title: Text('Ilova haqida'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.purple,
            ),
          ),
          ListTile(
            leading: Icon(Icons.call),
            onTap: () {},
            title: Text('Biz bilan aloqa'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.purple,
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              color: AppTheme.purple,
            ),
            onTap: () {
              ShowAlertDialog.showAlertDialog(
                context,
                'Tizimdan chiqish',
                'Rostnaham tizimdan chiqmoqchimisz',
                () async {
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  preferences.remove('token');
                  preferences.remove('image');
                  preferences.remove('bgimage');
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacementNamed(context, '/lang');
                },
              );
            },
            title: Text('Tizimdan chiqish'),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.purple,
            ),
          ),
        ],
      ),
    );
  }

  File? image, bgImage;
  String images = '';
  String bgImages = '';

  Future pickImage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
      preferences.setString("image", image.path);
      img();
    } on PlatformException catch (e) {}
  }

  img() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() => images = preferences.getString('image') ?? "");
    bgImages = preferences.getString('bgimage') ?? "";
  }

  Future backgroundImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => bgImage = imageTemp);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("bgimage", image.path);
      img();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }
}
