import 'package:attendance_management/router/attendance_router.gm.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/blocs/boundary/boundary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/entities/project_types.dart';
import '../pages/irswrapper.dart';
import '../router/app_router.dart';
import '../utils/utils.dart';

/// Wraps the [child] widget with a [BlocListener] that listens to
/// [BoundaryState] changes and navigates to [HomeRoute] when submitted.
class BoundarySelectionWrapper extends StatelessWidget {
  final Widget child;

  const BoundarySelectionWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('yash again  ${context.projectTypeCode}');
    return BlocListener<BoundaryBloc, BoundaryState>(
      listener: (context, state) {
        if (state.hasSubmitted) {
          if (context.projectTypeCode == ProjectTypes.smc.toValue()) {
            context.navigateTo(
              SMCWrapperRoute(),
              onFailure: (failure) {
                AppLogger.instance.error(
                  title: 'BoundarySelectionWrapper',
                  message: failure.toString(),
                );
              },
            );
          }
        } else {
          context.navigateTo(
            IRSWrapperRoute(),
            onFailure: (failure) {
              AppLogger.instance.error(
                title: 'BoundarySelectionWrapper',
                message: failure.toString(),
              );
            },
          );
        }
      },
      child: child,
    );
  }
}
