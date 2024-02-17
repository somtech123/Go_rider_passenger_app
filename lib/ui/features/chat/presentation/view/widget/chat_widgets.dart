import 'package:flutter/material.dart';

Widget noMessages(BuildContext context) {
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'No messages here yet...',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
        Text(
          'Start a conversation and share events together.',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
        )
      ],
    ),
  );
}
