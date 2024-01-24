import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../utils/app_constant/app_color.dart';

class MyHomeScreenErrorView extends StatelessWidget {
  const MyHomeScreenErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_sharp,
              color: AppColor.primaryColor,
            ),
            SizedBox(height: 20.h),
            Text("Error! Couldn't load user detail",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
