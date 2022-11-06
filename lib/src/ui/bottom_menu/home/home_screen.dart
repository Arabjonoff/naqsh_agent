import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/widget/stack/stack_widget.dart';

import '../../../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Scaffold(
        backgroundColor: AppTheme.background,
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SvgPicture.asset('assets/icons/vvv.svg',fit: BoxFit.cover,),
            ),
            SingleChildScrollView(
              child: Column(
                children:  [
                   SizedBox(height: 52*h,),
                  const Text('Umuiy balans',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),),
                  const SizedBox(height: 32,),
                  Row(
                    children: const [
                      SizedBox(width: 20,),
                      Icon(Icons.refresh),
                      SizedBox(width: 20,),
                      Text('119 124.00 UZS',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),)
                    ],
                  ),
                  const SizedBox(height: 32,),
                  StackWidget(),
                ],
              ),
            )
          ],
        ),);
  }
}
