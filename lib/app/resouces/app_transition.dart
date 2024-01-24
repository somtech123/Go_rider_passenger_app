import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomNormalPageTransition extends CustomTransitionPage {
  CustomNormalPageTransition({required LocalKey key, required Widget child})
      : super(
          key: key,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 0),
          child: child,
        );
}

class CustomFadeTransition extends CustomTransitionPage {
  CustomFadeTransition({required LocalKey key, required Widget child})
      : super(
          key: key,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              FadeTransition(opacity: animation, child: child),
          transitionDuration: const Duration(milliseconds: 200),
          child: child,
        );
}

class CustomSizeTransition extends CustomTransitionPage {
  CustomSizeTransition({required LocalKey key, required Widget child})
      : super(
          key: key,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SizeTransition(
            sizeFactor: animation,
            axisAlignment: 0.0,
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
          child: child,
        );
}

class CustomSlideTransition extends CustomTransitionPage {
  CustomSlideTransition({required LocalKey key, required Widget child})
      : super(
          key: key,
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween(
              begin: const Offset(1.0, 0.0),
              end: const Offset(0.0, 0.0),
            ).animate(animation),
            child: child,
          ),
          transitionDuration: const Duration(milliseconds: 500),
          child: child,
        );
}
