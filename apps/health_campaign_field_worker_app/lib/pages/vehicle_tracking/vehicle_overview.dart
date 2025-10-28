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
import '../../utils/utils.dart';
import '../../widgets/header/back_navigation_help_header.dart';
import '../../widgets/localized.dart';
import '../../utils/i18_key_constants.dart' as i18_local;
import '../../widgets/showcase/showcase_wrappers.dart';
import '../../widgets/vehicle_tracking/vehicle_card.dart';

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

  _searchSelectedVehicleActionModel() {
    final vehicleTripActionBloc = context.read<VehicleTripActionBloc>();
    vehicleTripActionBloc
        .add(VehicleTripActionEvent.handleSearch(vehicleNo: widget.vehicleNo));
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
          footer: DigitCard(
              margin: const EdgeInsets.all(kPadding),
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              children: [
                vehicleStatus == VehicleStatusEnum.completed
                    ? const Offstage()
                    : DigitButton(
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
                                    label: localizations.translate(i18_local
                                        .vehicleTracking.startTripButtonLabel),
                                    action: (ctx) {
                                      Navigator.of(
                                        context,
                                        rootNavigator: true,
                                      ).pop(true);
                                    }),
                                secondaryAction: DigitDialogActions(
                                  label: localizations.translate(
                                      i18_local.common.coreCommonCancel),
                                  action: (ctx) => Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop(true),
                                ),
                              ),
                            );
                            if (context.mounted) {
                              if (submit ?? false) {
                                context.router.push(VehicleTripBookRoute(
                                    vehicleNo: widget.vehicleNo));
                              }
                            }
                          } else if (vehicleStatus ==
                              VehicleStatusEnum.onGoing) {
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
                                    label: localizations.translate(i18_local
                                        .vehicleTracking.endTripButtonLabel),
                                    action: (ctx) {
                                      Navigator.of(
                                        context,
                                        rootNavigator: true,
                                      ).pop(true);
                                    }),
                                secondaryAction: DigitDialogActions(
                                  label: localizations.translate(
                                      i18_local.common.coreCommonCancel),
                                  action: (ctx) => Navigator.of(
                                    context,
                                    rootNavigator: true,
                                  ).pop(true),
                                ),
                              ),
                            );
                            if (context.mounted &&
                                tripState.tripAction != null) {
                              if (submit ?? false) {
                                context.read<VehicleTripActionBloc>().add(
                                      VehicleTripActionEndTripEvent(
                                          isEditing: true,
                                          boundaryModel:
                                              RegistrationDeliverySingleton()
                                                  .boundary!,
                                          vehicleNo: widget.vehicleNo,
                                          tripAction: tripState.tripAction!),
                                    );
                              }
                            }
                          }
                        },
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

                return SliverToBoxAdapter(
                  child: DigitCard(
                      margin: const EdgeInsets.all(spacer2),
                      children: [
                        if (selectedVehicle != null)
                          VehicleCard(
                            vehicle: selectedVehicle,
                            vehicleActionModel: tripState.tripAction,
                            appLocalizations: localizations,
                            status: vehicleStatus,
                            type: VehicleCardType.all,
                            buttonText: localizations.translate(
                              i18_local.vehicleTracking.mapLabel,
                            ),
                            onTap: () {},
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
