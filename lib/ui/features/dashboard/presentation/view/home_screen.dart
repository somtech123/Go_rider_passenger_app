import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_event.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/state_view.dart/my_loaded_state_view.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/state_view.dart/my_loading_state_view.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/state_view.dart/my_error_state_view.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/home_screen_drawer.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomePageBloc>(context).add(RequestLocation());

    BlocProvider.of<HomePageBloc>(context).add(GetUserDetails());
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final HomePageBloc homeloc = BlocProvider.of<HomePageBloc>(context);

    return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          title: Text(
            AppStrings.home,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
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
          leadingWidth: 23.w,
          leading: SizedBox(
            width: 30.w,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.h),
                    child: GestureDetector(
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: SvgPicture.asset(
                        'assets/svgs/handburger_svg.svg',
                        height: 25.h,
                        width: 25.w,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: const HomeScreenDrawer(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // floatingActionButton: Padding(
        //   padding: EdgeInsets.all(20.h),
        //   child: PrimaryButton(
        //     onPressed: () {
        //       context.push('/rideDetail');
        //     },
        //     label: AppStrings.bookRide,
        //   ),
        // ),
        body: BlocListener<HomePageBloc, HomePageState>(
          listener: (context, state) {},
          bloc: homeloc,
          child: BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state.loadingState == LoadingState.loading) {
                return const MyHomeScreenLoadingView();
              } else if (state.loadingState == LoadingState.loaded) {
                return MyHomeScreenLoadedStateView(state: state);
              } else if (state.loadingState == LoadingState.error) {
                return const MyHomeScreenErrorView();
              } else {
                return const SizedBox();
              }
            },
          ),
        ));
  }
}
