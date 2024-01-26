import 'package:flutter/material.dart';
import 'package:go_rider/main.dart';

class AppMainWrapper extends StatefulWidget {
  const AppMainWrapper({
    super.key,
    required this.child,
  });
  final MaterialApp child;

  @override
  State<AppMainWrapper> createState() => _AppMainWrapperState();
}

class _AppMainWrapperState extends State<AppMainWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    log.wtf(state.name);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
