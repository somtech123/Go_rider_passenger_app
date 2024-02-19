import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/ui/shared/shared_widget/app_text_field.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomePageBloc homeloc = BlocProvider.of<HomePageBloc>(context);

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
        title: Text(
          'Select Destination',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.whiteColor),
        ),
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              children: [
                AbsorbPointer(
                  absorbing: true,
                  child: AppTextField(
                    hintText: 'Your Location',
                    borderRadius: 25,
                    controller: state.pickUpAddress,
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(width: 15.w),
                        SvgPicture.asset('assets/svgs/from.svg'),
                        SizedBox(width: 5.w),
                        Text(
                          'From: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: AppColor.greyColor),
                        )
                      ],
                    ),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (p0) {},
                  ),
                ),
                SizedBox(height: 20.h),
                InkWell(
                  onTap: () {
                    homeloc.add(SelectPickUpLocation(context: context));
                  },
                  child: AbsorbPointer(
                    absorbing: true,
                    child: AppTextField(
                      hintText: 'Your Destination',
                      borderRadius: 25,
                      prefixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(width: 15.w),
                          SvgPicture.asset('assets/svgs/to.svg'),
                          SizedBox(width: 5.w),
                          Text(
                            'To: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: AppColor.greyColor),
                          )
                        ],
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (p0) {},
                      controller: state.destinationAddress,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
