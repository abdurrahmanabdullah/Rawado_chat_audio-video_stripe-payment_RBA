import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rawado/gen/assets.gen.dart';
import 'package:svg_flutter/svg.dart';

import 'helpers/helper_methods.dart';

final class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(color: appColor()),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 200.h,
                width: 200.w,
                child: SvgPicture.asset(
                  Assets.icons.logo,
                ),
              )
            ]),
      ),
    );
  }
}
