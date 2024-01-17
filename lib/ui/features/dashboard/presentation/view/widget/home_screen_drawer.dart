import 'package:flutter/material.dart';
import 'package:go_rider/ui/features/dashboard/presentation/view/widget/drawer_header.dart';

class HomeScreenDrawer extends StatelessWidget {
  const HomeScreenDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            HomeDrawerHeader(),
          ],
        ),
      ),
    );
  }
}
