import 'package:collection/collection.dart';
import 'package:digit_components/widgets/digit_dialog.dart';
import 'package:digit_data_model/models/entities/product_variant.dart';
import 'package:digit_data_model/models/entities/user_action.dart';
import 'package:digit_ui_components/enum/app_enums.dart';
import 'package:digit_ui_components/services/location_bloc.dart';
import 'package:digit_ui_components/theme/digit_extended_theme.dart';
import 'package:digit_ui_components/theme/digit_theme.dart';
import 'package:digit_ui_components/theme/spacers.dart';
import 'package:digit_ui_components/widgets/atoms/digit_button.dart';
import 'package:digit_ui_components/widgets/molecules/digit_card.dart';
import 'package:digit_ui_components/widgets/scrollable_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/utils/utils.dart';

import 'package:registration_delivery/widgets/table_card/table_card.dart';

import '../../blocs/localization/app_localization.dart';
import '../../blocs/vehicle_tracking/search_vehicle_bloc_common_wrapper.dart';
import '../../blocs/vehicle_tracking/search_vehicles.dart';
import '../../blocs/vehicle_tracking/vehicle_trip_action.dart';
import '../../models/entities/vehicle_tracking/trip_actions.dart';
import '../../router/app_router.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';
import '../../utils/i18_key_constants.dart' as i18_local;

enum VehicleStatusEnum {
  none,
  onGoing,
  completed,
}

Map<VehicleStatusEnum, String> vehicleStatusMap = {
  VehicleStatusEnum.none: "none",
  VehicleStatusEnum.onGoing: "On Going",
  VehicleStatusEnum.completed: "Completed",
};

@RoutePage()
class VehicleOverviewPage extends LocalizedStatefulWidget {
  final String vehicleNo;
  const VehicleOverviewPage({super.key, required this.vehicleNo});

  @override
  State<VehicleOverviewPage> createState() => _VehicleOverviewPageState();
}

class _VehicleOverviewPageState extends State<VehicleOverviewPage> {
  SearchVehiclesState searchVehiclesState = const SearchVehiclesState(
    loading: false,
    vehicles: [],
  );

  @override
  void initState() {
    super.initState();
  }

  _searchSelectedVehicle() {
    final searchVehicleBlocWrapper = context.read<SearchVehicleBlocWrapper>();
    searchVehicleBlocWrapper.searchVehiclesBloc.add(
        SearchVehiclesEvent.searchByVehicleNo(
            projectId: RegistrationDeliverySingleton().projectId!,
            vehicleNo: widget.vehicleNo));
  }

  VehicleStatusEnum _getVehicleStatus(UserActionModel? userActionModel) {
    String? tripAction = userActionModel?.action;
    if (tripAction == "start") {
      return VehicleStatusEnum.onGoing;
    } else if (tripAction == "end") {
      return VehicleStatusEnum.completed;
    } else {
      return VehicleStatusEnum.none;
    }
  }

  String? _getVehicleType(ProductVariantModel? vehicle) {
    return vehicle?.additionalFields?.fields
        .firstWhereOrNull(
          (field) => field.key == "Vehicle Type",
        )
        ?.value;
  }

  @override
  Widget build(BuildContext context) {
    var localizations = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final textTheme = theme.digitTextTheme(context);
    return BlocBuilder<VehicleTripActionBloc, VehicleTripActionState>(
      builder: (context, tripState) {
        _searchSelectedVehicle();
        VehicleStatusEnum vehicleStatus =
            _getVehicleStatus(tripState.tripAction);
        return Scaffold(
            body: ScrollableContent(
          header: const BackNavigationHelpHeaderWidget(
            showHelp: false,
          ),
          enableFixedDigitButton: true,
          footer:
              DigitCard(margin: const EdgeInsets.only(top: spacer2), children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: spacer2),
              child: DigitButton(
                label: localizations.translate(
                  vehicleStatus == VehicleStatusEnum.onGoing
                      ? i18_local.vehicleTracking.endTripButtonLabel
                      : i18_local.vehicleTracking.startTripButtonLabel,
                ),
                isDisabled: false,
                type: DigitButtonType.secondary,
                size: DigitButtonSize.large,
                mainAxisSize: MainAxisSize.max,
                onPressed: () async {
                  if (vehicleStatus == VehicleStatusEnum.none) {
                    final submit = await DigitDialog.show<bool>(
                      context,
                      options: DigitDialogOptions(
                        titleText: localizations.translate(
                          i18_local.vehicleTracking.startTripTitle,
                        ),
                        contentText: localizations.translate(
                          i18_local.vehicleTracking.startTripContent,
                        ),
                        primaryAction: DigitDialogActions(
                            label: localizations.translate(
                                i18_local.vehicleTracking.startTripButtonLabel),
                            action: (ctx) {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pop(true);
                            }),
                        secondaryAction: DigitDialogActions(
                          label: localizations
                              .translate(i18_local.common.coreCommonCancel),
                          action: (ctx) => Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop(true),
                        ),
                      ),
                    );
                    if (context.mounted) {
                      if (submit ?? false) {
                        context.router.push(
                            VehicleTripBookRoute(vehicleNo: widget.vehicleNo));
                      }
                    }
                  } else if (vehicleStatus == VehicleStatusEnum.completed) {
                    final submit = await DigitDialog.show<bool>(
                      context,
                      options: DigitDialogOptions(
                        titleText: localizations.translate(
                          i18_local.vehicleTracking.endTripTitle,
                        ),
                        contentText: localizations.translate(
                          i18_local.vehicleTracking.endTripContent,
                        ),
                        primaryAction: DigitDialogActions(
                            label: localizations.translate(
                                i18_local.vehicleTracking.endTripButtonLabel),
                            action: (ctx) {
                              Navigator.of(
                                context,
                                rootNavigator: true,
                              ).pop(true);
                            }),
                        secondaryAction: DigitDialogActions(
                          label: localizations
                              .translate(i18_local.common.coreCommonCancel),
                          action: (ctx) => Navigator.of(
                            context,
                            rootNavigator: true,
                          ).pop(true),
                        ),
                      ),
                    );
                    if (context.mounted && tripState.tripAction != null) {
                      if (submit ?? false) {
                        context.read<VehicleTripActionBloc>().add(
                              VehicleTripActionEndTripEvent(
                                  isEditing: true,
                                  boundaryModel:
                                      RegistrationDeliverySingleton().boundary!,
                                  tripAction: tripState.tripAction!),
                            );
                      }
                    }
                  }
                },
              ),
            ),
          ]),
          slivers: [
            BlocBuilder<SearchVehiclesBloc, SearchVehiclesState>(
              builder: (context, vehicleState) {
                if (vehicleState.loading) {
                  return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                ProductVariantModel? selectedVehicle =
                    vehicleState.vehicles.firstOrNull;
                String? vehicleType = _getVehicleType(selectedVehicle);

                return SliverToBoxAdapter(
                  child: DigitCard(
                      margin: const EdgeInsets.all(spacer2),
                      children: [
                        Stack(
                          children: [
                            Align(
                              alignment: Alignment.topRight,
                              child: SizedBox(
                                width: 100,
                                child: DigitButton(
                                  label: localizations.translate(
                                    i18_local.vehicleTracking.mapLabel,
                                  ),
                                  isDisabled: false,
                                  type: DigitButtonType.secondary,
                                  size: DigitButtonSize.medium,
                                  mainAxisSize: MainAxisSize.max,
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(spacer2),
                                  child: Text(
                                    selectedVehicle?.sku ?? "",
                                    style: textTheme.headingL,
                                  ),
                                ),
                                StatusWidget(
                                  status: vehicleStatus,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: spacer2,
                                    right: spacer2,
                                  ),
                                  child: Column(
                                    children: [
                                      DigitTableCard(
                                        element: {
                                          localizations.translate(
                                            i18_local.vehicleTracking.dateStart,
                                          ): selectedVehicle
                                              ?.auditDetails?.createdTime,
                                          localizations.translate(
                                            i18_local
                                                .vehicleTracking.vehicleType,
                                          ): vehicleType,
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ]),
                );
              },
            ),
          ],
        ));
      },
    );
  }
}

class StatusWidget extends StatelessWidget {
  final VehicleStatusEnum status;
  const StatusWidget({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status) {
      case VehicleStatusEnum.onGoing:
        statusColor = Colors.green;
        break;
      case VehicleStatusEnum.completed:
        statusColor = Colors.green;
        break;
      case VehicleStatusEnum.none:
        statusColor = Colors.red;
        break;
    }
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(spacer2),
        child: Row(
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: 15,
              color: statusColor,
            ),
            const SizedBox(width: spacer1),
            Text(vehicleStatusMap[status] ?? ""),
          ],
        ),
      ),
    );
  }
}
