import 'package:flutter/material.dart';
import 'package:mindsight_admin_page/app_export.dart';
import 'package:mindsight_admin_page/widgets/custom_text.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/error.png",
            width: 350,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Page not found".tr,
                size: 24,
                weight: FontWeight.bold,
              ),
            ],
          )
        ],
      ),
    );
  }
}
