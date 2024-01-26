import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        iconTheme: const IconThemeData(color: AppColor.whiteColor),
        backgroundColor: AppColor.primaryColor,
        title: Text(
          'Chat',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.whiteColor),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.h),
            child: SvgPicture.asset(
              'assets/svgs/notification.svg',
              height: 20.h,
              width: 20.w,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              borderRadius: 25.r,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => _userCard(
                context,
                ontap: () => context.push('/chatDetail'),
              ),
              itemCount: 20,
            ))
          ],
        ),
      ),
    );
  }
}

Widget _userCard(BuildContext context, {required VoidCallback ontap}) {
  return Padding(
    padding: EdgeInsets.only(top: 10.h),
    child: SizedBox(
      height: 50.h,
      child: ListTile(
        onTap: ontap,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(radius: 30.r),
        trailing: Text(
          '0:23',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.darkColor,
              ),
        ),
        subtitle: Text(
          'Hello',
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColor.darkColor,
              ),
        ),
        title: Text(
          'Darrell Steward',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColor.darkColor,
              ),
        ),
      ),
    ),
  );
}
