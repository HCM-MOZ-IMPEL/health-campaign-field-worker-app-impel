import 'package:flutter/material.dart';

import '../router/app_router.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class SMCWrapperPage extends StatelessWidget {
  const SMCWrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}
