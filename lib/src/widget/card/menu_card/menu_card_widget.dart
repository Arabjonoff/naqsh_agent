import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';

class MenuCardWidget extends StatelessWidget {
  final String image;
  final Function() onTap;
  final EdgeInsets margin;

  const MenuCardWidget({Key? key, required this.image, required this.onTap, required this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppTheme.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 15,
              offset: Offset(4, 15),
              color: Color.fromRGBO(0, 0, 0, 0.1),
            )
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10.0),
              child: Image.asset(image),
            ),
            Text('4',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text('Hamyonlar'),
            ),
          ],
        ),
      ),
    );
  }
}
