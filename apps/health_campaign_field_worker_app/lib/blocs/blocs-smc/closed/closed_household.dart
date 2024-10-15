import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/address_type.dart';
import 'package:digit_data_model/utils/typedefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:registration_delivery/models/entities/household.dart';
import 'package:registration_delivery/models/entities/household_member.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';
import 'package:registration_delivery/models/entities/status.dart'
    as reg_status;
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/typedefs.dart';

part 'closed_household.freezed.dart';

typedef ClosedHouseholdEmitter = Emitter<ClosedHouseholdState>;

class ClosedHouseholdBloc
    extends Bloc<ClosedHouseholdEvent, ClosedHouseholdState> {
  final IndividualDataRepository individualRepository;

  final HouseholdDataRepository householdRepository;

  final HouseholdMemberDataRepository householdMemberRepository;

  final ProjectBeneficiaryDataRepository projectBeneficiaryRepository;

  final TaskDataRepository taskRepository;

  ClosedHouseholdBloc(
    super.initialState, {
    required this.individualRepository,
    required this.householdRepository,
    required this.householdMemberRepository,
    required this.projectBeneficiaryRepository,
    required this.taskRepository,
  }) {
    on(_handleSubmit);
    on(_handleSummary);
  }

  FutureOr<void> _handleSubmit(
    ClosedHouseholdSubmitEvent event,
    ClosedHouseholdEmitter emit,
  ) async {
    emit(state.copyWith(loading: true));

    var locality =
        LocalityModel(code: event.boundaryCode!, name: event.boundaryName);

    try {
      var address = AddressModel(
        latitude: event.latitude,
        longitude: event.longitude,
        locationAccuracy: event.locationAccuracy,
        type: AddressType.correspondence,
        locality: LocalityModel(
          code: event.boundaryCode!,
          name: event.boundaryName,
        ),
        tenantId: event.tenantId,
        rowVersion: 1,
        clientAuditDetails: ClientAuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      var household = HouseholdModel(
        clientReferenceId: IdGen.i.identifier,
        address: address,
        memberCount: 1,
        rowVersion: 1,
        tenantId: event.tenantId.toString(),
        longitude: event.longitude,
        latitude: event.latitude,
        clientAuditDetails: ClientAuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      var individual = IndividualModel(
        clientReferenceId: IdGen.i.identifier,
        tenantId: event.tenantId,
        rowVersion: 1,
        clientAuditDetails: ClientAuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      var name = NameModel(
        givenName: event.householdHeadName,
        individualClientReferenceId: individual.clientReferenceId,
        tenantId: event.tenantId,
        rowVersion: 1,
        clientAuditDetails: ClientAuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      var identifier = IdentifierModel(
        clientReferenceId: individual.clientReferenceId,
        tenantId: event.tenantId,
        rowVersion: 1,
        clientAuditDetails: ClientAuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      var projectBeneficiary = ProjectBeneficiaryModel(
        tag: event.tag,
        rowVersion: 1,
        tenantId: event.tenantId,
        clientReferenceId: IdGen.i.identifier,
        dateOfRegistration: DateTime.now().millisecondsSinceEpoch,
        projectId: event.projectId,
        beneficiaryClientReferenceId:
            event.BenefiiaryType == BeneficiaryType.individual.toString()
                ? individual.clientReferenceId
                : household.clientReferenceId,
        clientAuditDetails: ClientAuditDetails(
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          createdBy: event.loggedInUserUuid!,
        ),
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      individual = individual.copyWith(
        name: name,
        address: [
          address.copyWith(
            relatedClientReferenceId: individual.clientReferenceId,
            auditDetails: individual.auditDetails,
            clientAuditDetails: individual.clientAuditDetails,
            locality: locality,
          ),
        ],
        identifiers: [
          identifier.copyWith(
            identifierId: IdGen.i.identifier,
            identifierType: 'DEFAULT',
          ),
        ],
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
        clientAuditDetails: ClientAuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          lastModifiedTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );
      var householdMember = HouseholdMemberModel(
        householdClientReferenceId: household.clientReferenceId,
        individualClientReferenceId: individual.clientReferenceId,
        isHeadOfHousehold: true,
        tenantId: event.tenantId,
        rowVersion: 1,
        clientReferenceId: IdGen.i.identifier,
        clientAuditDetails: ClientAuditDetails(
          createdTime: DateTime.now().millisecondsSinceEpoch,
          lastModifiedBy: event.loggedInUserUuid!,
          createdBy: event.loggedInUserUuid!,
        ),
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      var task = TaskModel(
        additionalFields: TaskAdditionalFields(
          version: 1,
          fields: [
            AdditionalField(
              "Reason",
              event.reason,
            )
          ],
        ),
        projectBeneficiaryClientReferenceId:
            projectBeneficiary.clientReferenceId,
        clientReferenceId: IdGen.i.identifier,
        tenantId: event.tenantId,
        projectId: event.projectId,
        rowVersion: 1,
        address: address,
        status: reg_status.Status.closeHousehold.toValue(),
        auditDetails: AuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
        ),
        clientAuditDetails: ClientAuditDetails(
          createdBy: event.loggedInUserUuid!,
          createdTime: DateTime.now().millisecondsSinceEpoch,
        ),
      );

      await householdRepository.create(
        household.copyWith(
          address: address.copyWith(
            relatedClientReferenceId: household.clientReferenceId,
            auditDetails: individual.auditDetails,
            clientAuditDetails: individual.clientAuditDetails,
            locality: locality,
          ),
        ),
      );

      final initialModifiedAt = DateTime.now().millisecondsSinceEpoch;
      await individualRepository.create(
        individual.copyWith(
          address: [
            address.copyWith(
              relatedClientReferenceId: individual.clientReferenceId,
              auditDetails: individual.auditDetails,
              clientAuditDetails: individual.clientAuditDetails,
              locality: locality,
            ),
          ],
        ),
      );

      await projectBeneficiaryRepository.create(
        projectBeneficiary,
      );

      await householdMemberRepository.create(householdMember.copyWith(
          clientAuditDetails: householdMember.clientAuditDetails!.copyWith(
        lastModifiedTime: initialModifiedAt,
      )));

      await taskRepository.create(task);

      emit(state.copyWith(loading: false));
    } catch (error) {
      rethrow;
    }
  }

  FutureOr<void> _handleSummary(
    ClosedHouseholdSummaryEvent event,
    ClosedHouseholdEmitter emit,
  ) async {
    emit(state.copyWith(
      longitude: event.longitude,
      latitude: event.latitude,
      locationAccuracy: event.locationAccuracy,
      householdHeadName: event.householdHeadName,
    ));
  }
}

@freezed
class ClosedHouseholdEvent with _$ClosedHouseholdEvent {
  const factory ClosedHouseholdEvent.handleSubmit(
    String? boundaryCode,
    String? boundaryName,
    String? loggedInUserUuid,
    String? tenantId,
    String? projectId,
    String? BenefiiaryType, {
    String? reason,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default(0) double locationAccuracy,
    String? householdHeadName,
    String? tag,
    BuildContext? context,
  }) = ClosedHouseholdSubmitEvent;

  const factory ClosedHouseholdEvent.handleSummary({
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default(0) double locationAccuracy,
    String? householdHeadName,
  }) = ClosedHouseholdSummaryEvent;
}

@freezed
class ClosedHouseholdState with _$ClosedHouseholdState {
  const factory ClosedHouseholdState({
    @Default(false) bool loading,
    @Default(false) bool isEditing,
    @Default(0) double latitude,
    @Default(0) double longitude,
    @Default(0) double locationAccuracy,
    String? householdHeadName,
  }) = _ClosedHouseholdState;
}
