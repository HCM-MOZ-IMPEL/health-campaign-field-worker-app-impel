import 'dart:math';

import 'package:collection/collection.dart';
import 'package:digit_components/widgets/digit_card.dart';
import 'package:digit_data_model/data/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/registration_delivery.dart';

import '../../../data/repositories/custom_project_beneficairy.dart';
import '../../../data/repositories/custom_task.dart';
import '../../../models/entities/entities_smc/intervention_types.dart';
import '../../../utils/extensions/extensions.dart';
import '../../../utils/utils_smc/utils_smc.dart';
import '../../progress_indicator/progress_indicator.dart';
import '../../../models/entities/additional_fields_type.dart'
    as additional_fields_local;

class CustomBeneficiaryProgressBarBednet extends StatefulWidget {
  final String label;
  final String prefixLabel;

  const CustomBeneficiaryProgressBarBednet({
    super.key,
    required this.label,
    required this.prefixLabel,
  });

  @override
  State<CustomBeneficiaryProgressBarBednet> createState() =>
      _CustomBeneficiaryProgressBarBednetState();
}

class _CustomBeneficiaryProgressBarBednetState
    extends State<CustomBeneficiaryProgressBarBednet> {
  int current = 0;
  @override
  void didChangeDependencies() {
    final taskRepository =
        context.read<LocalRepository<TaskModel, TaskSearchModel>>()
            as CustomTaskLocalRepository;

    final projectBeneficairyRepository = context.read<
            LocalRepository<ProjectBeneficiaryModel,
                ProjectBeneficiarySearchModel>>()
        as CustomProjectBeneficiaryLocalRepository;

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

    // if (context.isDistributor) {
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
                  field.value == InterventionTypes.bednet.toValue(),
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
    // }
    // else {
    //   projectBeneficairyRepository.listenToChanges(
    //     query: ProjectBeneficiarySearchModel(
    //       projectId: [projectId ?? ''],
    //       beneficiaryRegistrationDateLte: lte,
    //       beneficiaryRegistrationDateGte: gte,
    //     ),
    //     listener: (data) async {
    //       if (mounted) {
    //         final now = DateTime.now();
    //         final gte = DateTime(
    //           now.year,
    //           now.month,
    //           now.day,
    //         );
    //         final lte = DateTime(
    //           now.year,
    //           now.month,
    //           now.day,
    //           23,
    //           59,
    //           59,
    //           999,
    //         );
    //         ProjectBeneficiarySearchModel projectBeneficiarySearchModel =
    //             ProjectBeneficiarySearchModel(
    //           beneficiaryRegistrationDateLte: lte,
    //           beneficiaryRegistrationDateGte: gte,
    //           projectId: [projectId ?? ''],
    //         );
    //         List<ProjectBeneficiaryModel> results =
    //             await projectBeneficairyRepository.progressBarSearch(
    //                 projectBeneficiarySearchModel, loggedInUserUuid);

    //         if (mounted) {
    //           setState(() {
    //             if (mounted) {
    //               current = results.length;
    //             }
    //           });
    //         }
    //       }
    //     },
    //   );
    // }
    // else {
    //   projectBeneficairyRepository.listenToChanges(
    //     query: ProjectBeneficiarySearchModel(
    //       projectId: [projectId ?? ''],
    //       beneficiaryRegistrationDateLte: lte,
    //       beneficiaryRegistrationDateGte: gte,
    //     ),
    //     listener: (data) async {
    //       if (mounted) {
    //         final now = DateTime.now();
    //         final gte = DateTime(
    //           now.year,
    //           now.month,
    //           now.day,
    //         );
    //         final lte = DateTime(
    //           now.year,
    //           now.month,
    //           now.day,
    //           23,
    //           59,
    //           59,
    //           999,
    //         );
    //         ProjectBeneficiarySearchModel projectBeneficiarySearchModel =
    //             ProjectBeneficiarySearchModel(
    //           beneficiaryRegistrationDateLte: lte,
    //           beneficiaryRegistrationDateGte: gte,
    //           projectId: [projectId ?? ''],
    //         );
    //         List<ProjectBeneficiaryModel> results =
    //             await projectBeneficairyRepository.progressBarSearch(
    //                 projectBeneficiarySearchModel, loggedInUserUuid);

    //         if (mounted) {
    //           setState(() {
    //             if (mounted) {
    //               current = results.length;
    //             }
    //           });
    //         }
    //       }
    //     },
    //   );
    // }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // int target = context.isDistributor ? 60 : 40;
    int target = 200;

    return DigitCard(
      child: ProgressIndicatorContainer(
        label:
            widget.label.replaceAll("{}", max(target - current, 0).toString()),
        prefixLabel: '$current ${widget.prefixLabel}',
        suffixLabel: target.toStringAsFixed(0),
        value: target == 0 ? 0 : min(current / target, 1),
      ),
    );
  }
}
