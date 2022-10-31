import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';

class OnTapWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  const OnTapWidget({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.purple
        ),
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Text(title,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: AppTheme.white),),
        ),
      ),
    );
  }
}
