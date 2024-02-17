import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/history/presentation/bloc/history_bloc.dart';
import 'package:go_rider/ui/features/history/presentation/bloc/history_bloc_event.dart';
import 'package:go_rider/ui/features/history/presentation/bloc/history_bloc_state.dart';
import 'package:go_rider/ui/features/history/presentation/view/state_view/error_state_view.dart';
import 'package:go_rider/ui/features/history/presentation/view/state_view/loaded_state_view.dart';
import 'package:go_rider/ui/features/history/presentation/view/state_view/loading_state_view.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<HistoryBloc>(context).add(GetRideHistory());
  }

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
        body: BlocBuilder<HistoryBloc, HistoryBlocState>(
          builder: (context, state) {
            if (state.loadingState == LoadingState.loading) {
              return const HistoryLoadingStateView();
            } else if (state.loadingState == LoadingState.loaded) {
              return HistoryLoadedStateView(data: state.historyModel!);
            } else {
              return const HistoryErrorStateView();
            }
          },
        ));
  }
}
