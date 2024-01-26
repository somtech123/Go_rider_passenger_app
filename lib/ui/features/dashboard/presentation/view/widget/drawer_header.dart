import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc.dart';
import 'package:go_rider/ui/features/dashboard/presentation/bloc/home_bloc_state.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';

// ignore: must_be_immutable
class HomeDrawerHeader extends StatelessWidget {
  HomeDrawerHeader({super.key, required this.scaffoldKey});
  GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: BlocBuilder<HomePageBloc, HomePageState>(
          builder: (context, state) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Padding(
                    //     padding: EdgeInsets.only(right: 15.h, bottom: 20.h),
                    //     child:
                    IconButton(
                        onPressed: () {
                          scaffoldKey.currentState!.closeDrawer();
                        },
                        icon: const Icon(Icons.close))
                    //)
                    ,
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40.r,
                      backgroundImage:
                          NetworkImage(AppStrings.dummyProfilePicture),
                    ),
                    title: Text(
                      state.userModel!.username!,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkColor,
                          ),
                    ),
                    subtitle: Text(
                      state.userModel!.email!,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.darkColor,
                          ),
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
