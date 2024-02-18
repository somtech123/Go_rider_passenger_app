import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/app/helper/local_state_helper.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_bloc.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_bloc_state.dart';
import 'package:go_rider/ui/features/account/presentation/bloc/account_event.dart';
import 'package:go_rider/ui/features/account/presentation/view/state_view/error_state_view.dart';
import 'package:go_rider/ui/features/account/presentation/view/state_view/loaded_state_view.dart';
import 'package:go_rider/ui/features/account/presentation/view/state_view/loading_state_view.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AccountBloc>(context).add(GetAccountDetail());
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
          title: Text(
            'Ride History',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColor.whiteColor),
          ),
        ),
        body: BlocBuilder<AccountBloc, AccountBlocState>(
          builder: (context, state) {
            if (state.loadingState == LoadingState.loading) {
              return const AccountLoadingStateView();
            } else if (state.loadingState == LoadingState.loaded) {
              return AccountLoadedStateView(state: state);
            } else {
              return const AccountErrorStateView();
            }
          },
        ));
  }
}
