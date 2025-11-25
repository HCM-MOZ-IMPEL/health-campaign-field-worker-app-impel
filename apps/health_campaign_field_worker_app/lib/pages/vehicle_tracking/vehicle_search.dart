import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_data_model/models/entities/user_action.dart';
import 'package:digit_scanner/blocs/scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:registration_delivery/registration_delivery.dart';

import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/global_search_parameters.dart';
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/localized.dart';

import '../../../utils/utils.dart';

import '../../../router/app_router.dart';
import '../../../widgets/widgets_bednet/custom_view_beneficiary_card_bednet.dart';

import '../../blocs/vehicle_tracking/search_vehicle_bloc_common_wrapper.dart';
import '../../blocs/vehicle_tracking/search_vehicles.dart';
import '../../blocs/vehicle_tracking/vehicle_trip_action.dart';
import '../../widgets/vehicle_tracking/vehicle_card.dart';
import '../../widgets/vehicle_tracking/view_vehicle_card.dart';
import '../custom_digit_scanner.dart';
import '../../utils/i18_key_constants.dart' as i18_local;

@RoutePage()
class VehicleSearchPage extends LocalizedStatefulWidget {
  const VehicleSearchPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<VehicleSearchPage> createState() => _VehicleSearchPageState();
}

class _VehicleSearchPageState extends LocalizedState<VehicleSearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isProximityEnabled = false;
  int offset = 0;
  int limit = 10;

  SearchVehiclesState searchVehiclesState = const SearchVehiclesState(
    loading: false,
    vehicles: [],
  );

  late final SearchVehicleBlocWrapper
      searchVehicleBlocWrapper; // Declare BlocWrapper

  @override
  void initState() {
    // Initialize the BlocWrapper with instances of SearchVehicleBloc
    searchVehicleBlocWrapper = context.read<SearchVehicleBlocWrapper>();
    context.read<LocationBloc>().add(const LoadLocationEvent());
    // Listen to state changes
    searchVehicleBlocWrapper.stateChanges.listen((state) {
      if (mounted) {
        setState(() {
          searchVehiclesState = state;
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    VehicleStatusEnum getVehicleStatus(UserActionModel? userActionModel) {
      String? tripAction = userActionModel?.action;
      if (tripAction == "start") {
        return VehicleStatusEnum.onGoing;
      } else if (tripAction == "end") {
        return VehicleStatusEnum.completed;
      } else {
        return VehicleStatusEnum.none;
      }
    }

    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) => Scaffold(
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification) {
              final metrics = scrollNotification.metrics;
              if (metrics.atEdge && metrics.pixels != 0) {
                triggerGlobalSearchEvent(isPagination: true);
              }
            }
            return true;
          },
          child: ScrollableContent(
              header: const Column(children: [
                BackNavigationHelpHeaderWidget(),
              ]),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(kPadding),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(kPadding),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              localizations.translate(
                                  i18_local.vehicleTracking.searchVehicle),
                              style: theme.textTheme.displayMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, locationState) {
                            return Column(
                              children: [
                                const Offstage(),
                                DigitSearchBar(
                                  controller: searchController,
                                  hintText: localizations.translate(
                                    i18.searchBeneficiary
                                        .beneficiarySearchHintText,
                                  ),
                                  textCapitalization: TextCapitalization.words,
                                  onChanged: (value) {
                                    searchVehicleBlocWrapper.clearEvent();
                                    if (value.isEmpty ||
                                        value.trim().length > 2) {
                                      triggerGlobalSearchEvent();
                                    }
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: kPadding * 2),
                        if (searchVehiclesState.resultsNotFound &&
                            !searchVehiclesState.loading &&
                            searchVehiclesState.vehicles.isEmpty)
                          DigitInfoCard(
                            description: localizations.translate(
                              i18_local.vehicleTracking.vehilceInfoDescription,
                            ),
                            title: localizations.translate(
                              i18.searchBeneficiary.beneficiaryInfoTitle,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (searchVehiclesState.loading)
                  const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, locationState) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          final i =
                              searchVehiclesState.vehicles.elementAt(index);
                          return Container(
                            margin: const EdgeInsets.only(bottom: kPadding),
                            child: ViewVehicleCard(
                              vehicle: i,
                              onOpenPressed: () async {
                                String? vehicleNo = i.variation;
                                if (vehicleNo == null) {
                                  return;
                                }
                                await context.router.push(
                                  VehicleOverviewRoute(
                                    vehicleNo: vehicleNo,
                                  ),
                                );

                                setState(() {
                                  isProximityEnabled = false;
                                });
                                searchController.clear();

                                searchVehicleBlocWrapper.clearEvent();
                              },
                            ),
                          );
                        },
                        childCount: searchVehiclesState.vehicles.length,
                      ),
                    );
                  },
                ),
              ]),
        ),
      ),
    );
  }

  void triggerGlobalSearchEvent({bool isPagination = false}) {
    if (!isPagination) {
      searchVehicleBlocWrapper.clearEvent();
    }
    if (isProximityEnabled || searchController.text.isNotEmpty) {
      searchVehicleBlocWrapper.searchVehiclesBloc.add(
          SearchVehiclesEvent.searchByVehicleNo(
              projectId: RegistrationDeliverySingleton().projectId!,
              vehicleNo: searchController.text.trim()));
    }
  }
}
