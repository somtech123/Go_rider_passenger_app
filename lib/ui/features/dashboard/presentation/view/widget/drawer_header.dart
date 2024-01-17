import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDrawerHeader extends StatelessWidget {
  const HomeDrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 15.h, bottom: 20.h),
                  child: Icon(Icons.close),
                ),
              ],
            ),
            Container(
              alignment: Alignment.center,
              child: ListTile(
                leading: CircleAvatar(radius: 40.r),
                title: Text('Nkechi Florence Baig'),
                subtitle: Text('seyi@gmail.com'),
              ),
            ),
          ],
        ));
  }
}
