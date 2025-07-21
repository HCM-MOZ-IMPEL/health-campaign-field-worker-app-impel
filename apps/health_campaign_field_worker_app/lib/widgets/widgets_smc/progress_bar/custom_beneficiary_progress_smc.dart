import 'dart:math';

import 'package:collection/collection.dart';
import 'package:digit_components/widgets/digit_card.dart';
import 'package:digit_data_model/data/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/data/repositories/local/task.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/registration_delivery.dart';

import '../../../data/repositories/custom_task.dart';
import '../../../utils/constants.dart';
import '../../progress_indicator/progress_indicator.dart';

class CustomBeneficiaryProgressBarSMC extends StatefulWidget {
  final String label;
  final String prefixLabel;

  const CustomBeneficiaryProgressBarSMC({
    Key? key,
    required this.label,
    required this.prefixLabel,
  }) : super(key: key);

  @override
  State<CustomBeneficiaryProgressBarSMC> createState() =>
      _CustomBeneficiaryProgressBarSMCState();
}

class _CustomBeneficiaryProgressBarSMCState
    extends State<CustomBeneficiaryProgressBarSMC> {
  int current = 0;
  @override
  void didChangeDependencies() {
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
        status: Status.administeredSuccess.toValue(),
        projectId: projectId,
        createdBy: loggedInUserUuid,
        plannedEndDate: lte.millisecondsSinceEpoch,
        plannedStartDate: gte.millisecondsSinceEpoch,
      ),
      listener: (taskData) async {
        if (mounted) {
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
          TaskSearchModel taskSearchQuery = TaskSearchModel(
            status: Status.administeredSuccess.toValue(),
            createdBy: loggedInUserUuid,
            plannedEndDate: lte.millisecondsSinceEpoch,
            plannedStartDate: gte.millisecondsSinceEpoch,
            projectId: projectId,
          );
          // List<TaskModel> results =
          //     await taskRepository.progressBarSearch(taskSearchQuery);
          List<TaskModel> allTasks =
              await taskRepository.progressBarSearch(taskSearchQuery);
          // List<TaskModel> results = allTasks
          //     .where((task) => isHeadBednetDelivered([task]))
          //     .toList();
          List<TaskModel> results = allTasks.where((task) {
            if (task == null) return false;
            final additionalFields = task.additionalFields?.fields;
            if (additionalFields == null || additionalFields.isEmpty)
              return false;

            try {
              final smcField = additionalFields.firstWhereOrNull(
                (field) => field != null && field.key == Constants.smcDeliver,
              );

              if (smcField == null) return false;
              final fieldValue = smcField.value;
              if (fieldValue == null) return false;

              return fieldValue == true ||
                  fieldValue == Constants.trueString ||
                  fieldValue.toString().toLowerCase() == Constants.trueString;
            } catch (e) {
              return false;
            }
          }).toList();
          final groupedEntries = results.groupListsBy(
            (element) => element.projectBeneficiaryClientReferenceId,
          );
          if (mounted) {
            setState(() {
              if (mounted) {
                current = groupedEntries.entries.length;
              }
            });
          }
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    const target = 65;

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
