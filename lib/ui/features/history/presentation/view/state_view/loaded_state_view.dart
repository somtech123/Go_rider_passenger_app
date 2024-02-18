import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/features/history/data/history_model.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HistoryLoadedStateView extends StatelessWidget {
  HistoryLoadedStateView({super.key, required this.data});

  List<HistoryModel> data;

  @override
  Widget build(BuildContext context) {
    return Column(
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
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => _historyCard(
              context,
              destination: data[index].destination!,
              pickUp: data[index].pickUpLocation!,
              price: data[index].amount!,
              date: data[index].dateCreated!,
            ),
            itemCount: data.length,
          ),
        )
      ],
    );
  }
}

Widget _historyCard(
  BuildContext context, {
  required String destination,
  required String pickUp,
  required String price,
  required DateTime date,
}) {
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
            height: 40.h,
            child: ListTile(
              leading: SvgPicture.asset('assets/svgs/home.svg'),
              title: Text(
                destination,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12),
              ),
              trailing: Text(
                DateFormat('dd/MMMM/yyyy').format(date),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w400, fontSize: 12),
              ),
            ),
          ),
          // SizedBox(height: 20.h),
          SizedBox(
            height: 30.h,
            child: ListTile(
              leading: SvgPicture.asset('assets/svgs/location.svg'),
              title: Text(
                pickUp,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w500, fontSize: 14),
              ),
              trailing: Text(
                "Usd$price",
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
