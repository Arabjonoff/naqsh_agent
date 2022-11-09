import 'package:flutter/material.dart';
import 'package:naqsh_agent/src/theme/app_theme.dart';
import 'package:naqsh_agent/src/widget/card/banner_card/banner_card_widget.dart';
import 'package:naqsh_agent/src/widget/card/menu_card/menu_card_widget.dart';

import '../../utils/utils.dart';

class StackWidget extends StatelessWidget {
  const StackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = Utils.getWidth(context);
    double h = Utils.getHeight(context);
    return Stack(
      children: [
        Container(
          height: 213*w,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: AppTheme.indigo,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Oktyabr, 2022',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16*h,color: AppTheme.white),),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BannerCardWidget(),
                  BannerCardWidget(),
                  BannerCardWidget(),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 150.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
              height: 650*w,
              decoration: const BoxDecoration(
              color: AppTheme.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: GridView.count(
              physics: const ScrollPhysics(),
              crossAxisSpacing: 14,
              childAspectRatio: 1.3*w,
              mainAxisSpacing: 14,
              crossAxisCount: 2,
            children: [
              MenuCardWidget(image: 'assets/icons/purse.png', onTap: () => Navigator.pushNamed(context, '/wallet'), margin: EdgeInsets.only(left: 20*w),),
              MenuCardWidget(image: 'assets/icons/agent.png', onTap: () => Navigator.pushNamed(context, '/agent'), margin: EdgeInsets.only(right: 20*w),),
              MenuCardWidget(image: 'assets/icons/download.png', onTap: () => Navigator.pushNamed(context, '/income') , margin: EdgeInsets.only(left: 20*w),),
              MenuCardWidget(image: 'assets/icons/upload.png', onTap: () => Navigator.pushNamed(context, '/debt'), margin: EdgeInsets.only(right: 20*w),),
              MenuCardWidget(image: 'assets/icons/calculator.png', onTap: ()=> Navigator.pushNamed(context, '/expense'), margin: EdgeInsets.only(left: 20*w),),
            ],)
          ),
        ),
      ],
    );
  }
}
