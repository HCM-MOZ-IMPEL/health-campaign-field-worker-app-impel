import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
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

import '../custom_digit_scanner.dart';

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

  double lat = 0.0;
  double long = 0.0;

  SearchHouseholdsState searchHouseholdsState = const SearchHouseholdsState(
    loading: false,
    householdMembers: [],
  );

  late final SearchBlocWrapper blocWrapper; // Declare BlocWrapper

  @override
  void initState() {
    // Initialize the BlocWrapper with instances of SearchHouseholdsBloc, SearchMemberBloc, and ProximitySearchBloc
    blocWrapper = context.read<SearchBlocWrapper>();
    context.read<LocationBloc>().add(const LoadLocationEvent());
    // Listen to state changes
    blocWrapper.stateChanges.listen((state) {
      if (mounted) {
        setState(() {
          searchHouseholdsState = state;
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
                            localizations.translate("SEARCH_VEHICLE_LABEL"),
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
                                  blocWrapper.clearEvent();
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
                      if (searchHouseholdsState.resultsNotFound &&
                          !searchHouseholdsState.loading)
                        DigitInfoCard(
                          description: localizations.translate(
                            i18.searchBeneficiary.beneficiaryInfoDescription,
                          ),
                          title: localizations.translate(
                            i18.searchBeneficiary.beneficiaryInfoTitle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (searchHouseholdsState.loading)
                const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              BlocListener<DigitScannerBloc, DigitScannerState>(
                listener: (context, scannerState) {
                  if (scannerState.qrCodes.isNotEmpty) {
                    context.read<SearchBlocWrapper>().tagSearchBloc.add(
                          SearchHouseholdsEvent.searchByTag(
                            tag: scannerState.qrCodes.isNotEmpty
                                ? scannerState.qrCodes.lastOrNull!
                                : '',
                            projectId:
                                RegistrationDeliverySingleton().projectId!,
                          ),
                        );
                  }
                },
                child: BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, locationState) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (ctx, index) {
                          final i = searchHouseholdsState.householdMembers
                              .elementAt(index);
                          final distance = calculateDistance(
                            Coordinate(
                              lat,
                              long,
                            ),
                            Coordinate(
                              i.household?.address?.latitude,
                              i.household?.address?.longitude,
                            ),
                          );

                          return (i.projectBeneficiaries == null ||
                                  i.projectBeneficiaries!.isEmpty)
                              ? const Offstage()
                              : Container(
                                  margin:
                                      const EdgeInsets.only(bottom: kPadding),
                                  child: CustomViewBeneficiaryCardBednet(
                                    distance:
                                        isProximityEnabled ? distance : null,
                                    householdMember: i,
                                    onOpenPressed: () async {
                                      final scannerBloc =
                                          context.read<DigitScannerBloc>();

                                      scannerBloc.add(
                                        const DigitScannerEvent.handleScanner(),
                                      );

                                      if ((i.tasks != null &&
                                              i.tasks?.last.status ==
                                                  Status.closeHousehold
                                                      .toValue() &&
                                              (i.tasks ?? []).isNotEmpty) ||
                                          (i.projectBeneficiaries ?? [])
                                              .isEmpty) {
                                        setState(() {});
                                        blocWrapper.clearEvent();
                                        await context.router.push(
                                          BeneficiaryRegistrationWrapperRoute(
                                            initialState: BeneficiaryRegistrationState
                                                .editHousehold(
                                                    householdModel: i
                                                        .household!,
                                                    individualModel: i.members!,
                                                    registrationDate:
                                                        DateTime.now(),
                                                    projectBeneficiaryModel:
                                                        (i.projectBeneficiaries ??
                                                                    [])
                                                                .isNotEmpty
                                                            ? i
                                                                .projectBeneficiaries
                                                                ?.last
                                                            : null,
                                                    addressModel: i
                                                        .headOfHousehold!
                                                        .address!
                                                        .last,
                                                    headOfHousehold:
                                                        i.headOfHousehold),
                                          ),
                                        );
                                      } else {
                                        await context.router.push(
                                          CustomHouseholdWrapperRoute(
                                            wrapper: i,
                                          ),
                                        );
                                      }
                                      setState(() {
                                        isProximityEnabled = false;
                                      });
                                      searchController.clear();

                                      blocWrapper.clearEvent();
                                    },
                                  ),
                                );
                        },
                        childCount:
                            searchHouseholdsState.householdMembers.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: context.isDistributor ? 70 : 70,
          child: Card(
            margin: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
              child: Column(
                children: [
                  if (context.isRegistrar || context.isDistributor)
                    DigitElevatedButton(
                      onPressed: searchHouseholdsState.loading ||
                              searchHouseholdsState.searchQuery == null
                          ? null
                          : () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              context.read<DigitScannerBloc>().add(
                                    const DigitScannerEvent.handleScanner(),
                                  );
                              context.router
                                  .push(BeneficiaryRegistrationWrapperRoute(
                                initialState:
                                    BeneficiaryRegistrationCreateState(
                                  searchQuery:
                                      searchHouseholdsState.searchQuery,
                                ),
                              ));
                              searchController.clear();

                              blocWrapper.clearEvent();
                            },
                      child: Center(
                        child: Text(localizations.translate(
                          i18.searchBeneficiary.beneficiaryAddActionLabel,
                        )),
                      ),
                    ),
                  Offstage(
                    offstage: true,
                    child: DigitOutlineIconButton(
                      buttonStyle: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () {
                        blocWrapper.clearEvent();

                        searchController.clear();
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const CustomDigitScannerPage(
                              quantity: 1,
                              isGS1code: false,
                              singleValue: true,
                            ),
                            settings: const RouteSettings(name: '/qr-scanner'),
                          ),
                        );
                      },
                      icon: Icons.qr_code,
                      label: localizations.translate(
                        i18.deliverIntervention.scannerLabel,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  getFilterIconNLabel() {
    return {
      'label': localizations.translate(
        i18.searchBeneficiary.filterLabel,
      ),
      'icon': Icons.filter_alt
    };
  }

  void triggerGlobalSearchEvent({bool isPagination = false}) {
    if (!isPagination) {
      blocWrapper.clearEvent();
    }
    if (RegistrationDeliverySingleton().beneficiaryType ==
        BeneficiaryType.individual) {
      if (isProximityEnabled || searchController.text.isNotEmpty) {
        blocWrapper.individualGlobalSearchBloc
            .add(SearchHouseholdsEvent.individualGlobalSearch(
                globalSearchParams: GlobalSearchParameters(
          isProximityEnabled: isProximityEnabled,
          latitude: lat,
          longitude: long,
          maxRadius: RegistrationDeliverySingleton().maxRadius,
          nameSearch: searchController.text.trim().length > 2
              ? searchController.text.trim()
              : blocWrapper.searchHouseholdsBloc.state.searchQuery,
          filter: [],
          offset: isPagination
              ? blocWrapper.houseHoldGlobalSearchBloc.state.offset
              : offset,
          limit: isPagination
              ? blocWrapper.houseHoldGlobalSearchBloc.state.limit
              : limit,
        )));
      }
    } else {
      if (isProximityEnabled || searchController.text.isNotEmpty) {
        blocWrapper.houseHoldGlobalSearchBloc
            .add(SearchHouseholdsEvent.houseHoldGlobalSearch(
                globalSearchParams: GlobalSearchParameters(
          projectId: RegistrationDeliverySingleton().projectId,
          isProximityEnabled: isProximityEnabled,
          latitude: lat,
          longitude: long,
          maxRadius: RegistrationDeliverySingleton().maxRadius,
          nameSearch: searchController.text.trim().length > 2
              ? searchController.text.trim()
              : blocWrapper.searchHouseholdsBloc.state.searchQuery,
          filter: [],
          offset: isPagination
              ? blocWrapper.houseHoldGlobalSearchBloc.state.offset
              : offset,
          limit: isPagination
              ? blocWrapper.houseHoldGlobalSearchBloc.state.limit
              : limit,
        )));
      }
    }
  }

  String getStatus(String selectedFilter) {
    final statusMap = {
      Status.delivered.toValue(): Status.delivered,
      // Status.notDelivered.toValue(): Status.notDelivered,
      Status.visited.toValue(): Status.visited,
      Status.notVisited.toValue(): Status.notVisited,
      Status.beneficiaryRefused.toValue(): Status.beneficiaryRefused,
      Status.beneficiaryReferred.toValue(): Status.beneficiaryReferred,
      Status.administeredSuccess.toValue(): Status.administeredSuccess,
      Status.administeredFailed.toValue(): Status.administeredFailed,
      Status.inComplete.toValue(): Status.inComplete,
      Status.toAdminister.toValue(): Status.toAdminister,
      Status.closeHousehold.toValue(): Status.closeHousehold,
      Status.registered.toValue(): Status.registered,
      Status.notRegistered.toValue(): Status.notRegistered,
    };

    var mappedStatus = statusMap.entries
        .where((element) => element.value.name == selectedFilter)
        .first
        .key;
    if (mappedStatus != null) {
      return mappedStatus;
    } else {
      return selectedFilter;
    }
  }
}
