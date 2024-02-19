import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

List<TargetFocus> inAppTutor({required GlobalKey addCategoryKey}) {
  List<TargetFocus> _tagets = [];
  _tagets.add(
    TargetFocus(
        keyTarget: addCategoryKey,
        radius: 10,
        shape: ShapeLightFocus.Circle,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Call during emergency',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              );
            },
          )
        ]),
  );
  return _tagets;
}
