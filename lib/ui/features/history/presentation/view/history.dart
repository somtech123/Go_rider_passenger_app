import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        iconTheme: const IconThemeData(color: AppColor.whiteColor),
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
        title: Text(
          'Ride History',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.whiteColor),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 15.h),
            child: Text(
              'Showing Ride History',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColor.darkColor),
            ),
          ),
          Expanded(
            flex: 1,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) => _historyCard(context),
              itemCount: 10,
            ),
          )
        ],
      ),
    );
  }
}

Widget _historyCard(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(10.h),
    child: Container(
      height: 90.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: AppColor.whiteColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: const [
          BoxShadow(
            color: AppColor.fillColor,
            spreadRadius: 5,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
            child: ListTile(
              leading: SvgPicture.asset('assets/svgs/home.svg'),
              title: Text(
                'Daniyore Gilgit',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12),
              ),
              trailing: Text(
                '06/April/2023',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 20.h,
            child: ListTile(
              leading: SvgPicture.asset('assets/svgs/location.svg'),
              title: Text(
                'Home',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              trailing: Text(
                "Usd320",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
