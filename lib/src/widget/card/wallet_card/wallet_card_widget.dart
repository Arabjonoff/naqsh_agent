import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';

class WalletCardWidget extends StatelessWidget {
  final Function() onTap;
  const WalletCardWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 7.5),
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [ Color(0xFF885DF5),Color(0xFF5F6DF8),],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  const [
            Text('Plastik karta',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,color: AppTheme.white),),
            SizedBox(height: 35,),
            Text('Umumiy balans',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 10,color: AppTheme.white),),
            SizedBox(height: 5,),
            Text('5 252 890',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 30,color: AppTheme.white),),
            SizedBox(height: 15,),
            Text('Valyuta : sum',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: AppTheme.white),),
          ],
        ),
      ),
    );
  }
}
