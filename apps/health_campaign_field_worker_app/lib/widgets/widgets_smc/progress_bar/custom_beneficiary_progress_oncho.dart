import 'dart:math';

import 'package:collection/collection.dart';
import 'package:digit_components/widgets/digit_card.dart';
import 'package:digit_data_model/data/data_repository.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/data/repositories/local/task.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/registration_delivery.dart';
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;

import '../../../data/repositories/custom_task.dart';
import '../../../models/entities/entities_smc/intervention_types.dart';
import '../../progress_indicator/progress_indicator.dart';

class CustomBeneficiaryProgressBarOncho extends StatefulWidget {
  final String label;
  final String prefixLabel;

  const CustomBeneficiaryProgressBarOncho({
    Key? key,
    required this.label,
    required this.prefixLabel,
  }) : super(key: key);

  @override
  State<CustomBeneficiaryProgressBarOncho> createState() =>
      _CustomBeneficiaryProgressBarOnchoState();
}

class _CustomBeneficiaryProgressBarOnchoState
    extends State<CustomBeneficiaryProgressBarOncho> {
  int current = 0;
  bool isExpanded = false;

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

          List<TaskModel> allTasks =
              await taskRepository.progressBarSearch(taskSearchQuery);
          List<TaskModel> results = allTasks.where((task) {
            final additionalFields = task?.additionalFields?.fields;
            if (additionalFields == null || additionalFields.isEmpty) {
              return false;
            }

            return additionalFields.any(
              (field) =>
                  field != null &&
                  field.key ==
                      additional_fields_local
                          .AdditionalFieldsType.interventionType
                          .toValue() &&
                  field.value == InterventionTypes.oncho.toValue(),
            );
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
    final theme = Theme.of(context);
    const target = 200;

    return DigitCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProgressIndicatorContainer(
            label: widget.label
                .replaceAll("{}", max(target - current, 0).toString()),
            prefixLabel: '$current ${widget.prefixLabel}',
            suffixLabel: target.toString(),
            value: target == 0 ? 0 : min(current / target, 1),
          ),
        ],
      ),
    );
  }
}
