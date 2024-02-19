import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/shared/shared_widget/primary_button.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';
import 'package:go_rider/utils/utils/currency_formater.dart';
import 'package:go_router/go_router.dart';

var log = getLogger('availableride');

// ignore: must_be_immutable
class AvailableRideWideget extends StatefulWidget {
  AvailableRideWideget({super.key, required this.rider});
  List<RiderModel> rider;

  @override
  State<AvailableRideWideget> createState() => _AvailableRideWidegetState();
}

class _AvailableRideWidegetState extends State<AvailableRideWideget> {
  int currentIndex = 0;

  PageController? pageController;

  @override
  void initState() {
    pageController = PageController(viewportFraction: 0.5, initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200.h,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.rider.length,
            scrollDirection: Axis.horizontal,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 10.h, right: 10.h),
                child: AvailableRideContainer(
                  vehicleName: widget.rider[index].rideModel!,
                  vehiclePlate: widget.rider[index].ridePlate!,
                  type: '${widget.rider[index].noOfSeat} Seat Ride',
                  activeIndex: index,
                  currentIndex: currentIndex,
                  price:
                      CurrencyUtils.formatCurrency.format(double.parse('340')),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20.h),
        SizedBox(
          width: 300.w,
          child: PrimaryButton(
            onPressed: () {
              BlocProvider.of<HomePageBloc>(context).add(
                  GetRiderLocation(riderId: widget.rider[currentIndex].id!));

              context.push('/rideDetail', extra: widget.rider[currentIndex]);
            },
            label: AppStrings.bookRide,
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class AvailableRideContainer extends StatelessWidget {
  AvailableRideContainer(
      {super.key,
      required this.vehicleName,
      required this.vehiclePlate,
      required this.price,
      required this.activeIndex,
      required this.currentIndex,
      required this.type});
  final String vehicleName;
  final String vehiclePlate;
  final String type;
  final String price;
  int activeIndex;
  int currentIndex;

  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 5),
      curve: Curves.fastOutSlowIn,
      width: 250.w,
      padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        color:
            activeIndex == currentIndex ? AppColor.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            vehicleName,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 18,
                color: activeIndex == currentIndex
                    ? AppColor.whiteColor
                    : AppColor.darkColor,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5.h),
          Text(
            vehiclePlate,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                color: activeIndex == currentIndex
                    ? AppColor.whiteColor
                    : AppColor.darkColor,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.h),
          Text(
            type,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                color: activeIndex == currentIndex
                    ? AppColor.whiteColor
                    : AppColor.darkColor,
                fontWeight: FontWeight.w500),
          ),
          SvgPicture.asset(
            'assets/svgs/car.svg',
            height: 95.h,
          ),
          Text(
            price,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                color: activeIndex == currentIndex
                    ? AppColor.whiteColor
                    : AppColor.darkColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
