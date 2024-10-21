import 'dart:math';

import 'package:collection/collection.dart';
import 'package:digit_components/widgets/digit_card.dart';
import 'package:digit_data_model/data/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:registration_delivery/data/repositories/local/project_beneficiary.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/utils.dart';
import '../../data/repositories/custom_task.dart';
import '../../models/entities/project_types.dart';
import '../../utils/extensions/extensions.dart';
import '../progress_indicator/progress_indicator.dart';

class CustomBeneficiaryProgressBar extends StatefulWidget {
  final String label;
  final String prefixLabel;

  const CustomBeneficiaryProgressBar({
    super.key,
    required this.label,
    required this.prefixLabel,
  });

  @override
  State<CustomBeneficiaryProgressBar> createState() =>
      CustomBeneficiaryProgressBarState();
}

class CustomBeneficiaryProgressBarState
    extends State<CustomBeneficiaryProgressBar> {
  int current = 0;

  @override
  void didChangeDependencies() {
    final repository = context.read<
            LocalRepository<ProjectBeneficiaryModel,
                ProjectBeneficiarySearchModel>>()
        as ProjectBeneficiaryLocalRepository;

    final taskRepository =
        context.read<LocalRepository<TaskModel, TaskSearchModel>>()
            as CustomTaskLocalRepository;

    final projectId = RegistrationDeliverySingleton().projectId;
    final loggedInUserUuid = RegistrationDeliverySingleton().loggedInUserUuid;

    final now = DateTime.now();
    final gte = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final lte = DateTime(
      now.year,
      now.month,
      now.day,
      23,
      59,
      59,
      999,
    );

    taskRepository.listenToChanges(
      query: TaskSearchModel(
        projectId: projectId,
        createdBy: loggedInUserUuid,
        status: Status.administeredSuccess.toValue(),
        plannedEndDate: lte.millisecondsSinceEpoch,
        plannedStartDate: gte.millisecondsSinceEpoch,
      ),
      listener: (data) {
        if (mounted) {
          setState(() {
            current = data.length;
          });
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final target =
        context.projectTypeCode == ProjectTypes.smc.toValue() ? 65.0 : 8.0;

    return DigitCard(
      child: ProgressIndicatorContainer(
        label: '${max(target - current, 0).round()} ${widget.label}',
        prefixLabel: '$current ${widget.prefixLabel}',
        suffixLabel: target.toStringAsFixed(0),
        value: target == 0 ? 0 : min(current / target, 1),
      ),
    );
  }
}
