import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/drawer_header.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';
import 'package:go_router/go_router.dart';

// ignore: must_be_immutable
class HomeScreenDrawer extends StatelessWidget {
  HomeScreenDrawer({super.key, required this.scaffoldKey});
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeDrawerHeader(scaffoldKey: scaffoldKey),
            _drawerList(context),
          ],
        ),
      ),
    );
  }
}

Widget _drawerList(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(20.h),
    child: Column(
      children: [
        _drawerItem(
          context,
          svgPath: 'assets/svgs/profile.svg',
          name: AppStrings.acount,
          ontap: () {
            context.push('/account');
          },
        ),
        SizedBox(height: 20.h),
        _drawerItem(
          context,
          svgPath: 'assets/svgs/lock.svg',
          name: AppStrings.privacy,
          ontap: () {},
        ),
        SizedBox(height: 20.h),
        _drawerItem(
          context,
          svgPath: 'assets/svgs/privacy.svg',
          name: AppStrings.histroy,
          ontap: () {
            context.push('/historyPage');
          },
        ),
        SizedBox(height: 20.h),
        _drawerItem(
          context,
          svgPath: 'assets/svgs/localization.svg',
          name: AppStrings.local,
          ontap: () {},
        ),
        SizedBox(height: 20.h),
        _drawerItem(
          context,
          svgPath: 'assets/svgs/help_svg.svg',
          name: AppStrings.help,
          ontap: () {},
        ),
        SizedBox(height: 20.h),
        _drawerItem(
          context,
          svgPath: 'assets/svgs/invite.svg',
          name: AppStrings.invite,
          ontap: () {},
        ),
        SizedBox(height: 20.h),
        _drawerItem(
          context,
          svgPath: 'assets/svgs/logout_svg.svg',
          name: AppStrings.logout,
          ontap: () {},
        ),
      ],
    ),
  );
}

Widget _drawerItem(BuildContext context,
    {required String svgPath,
    required String name,
    required VoidCallback ontap}) {
  return ListTile(
    onTap: ontap,
    leading: SvgPicture.asset(svgPath),
    title: Text(
      name,
      style: Theme.of(context)
          .textTheme
          .bodyMedium!
          .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
    ),
  );
}
