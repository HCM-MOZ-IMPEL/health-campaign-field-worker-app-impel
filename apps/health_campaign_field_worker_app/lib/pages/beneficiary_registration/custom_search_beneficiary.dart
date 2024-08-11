import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:digit_scanner/blocs/scanner.dart';
import 'package:digit_scanner/pages/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:registration_delivery/blocs/search_households/individual_global_search.dart';
import 'package:registration_delivery/registration_delivery.dart';

import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;
import 'package:registration_delivery/models/entities/status.dart';
import 'package:registration_delivery/router/registration_delivery_router.gm.dart';
import 'package:registration_delivery/utils/global_search_parameters.dart';
import 'package:registration_delivery/utils/utils.dart';
import 'package:registration_delivery/widgets/back_navigation_help_header.dart';
import 'package:registration_delivery/widgets/beneficiary/view_beneficiary_card.dart';
import 'package:registration_delivery/widgets/localized.dart';
import 'package:registration_delivery/widgets/status_filter/status_filter.dart';

import '../../widgets/beneficiary/custom_view_beneficiary_card.dart';

import '../../router/app_router.dart';

@RoutePage()
class CustomSearchBeneficiaryPage extends LocalizedStatefulWidget {
  const CustomSearchBeneficiaryPage({
    super.key,
    super.appLocalizations,
  });

  @override
  State<CustomSearchBeneficiaryPage> createState() =>
      _CustomSearchBeneficiaryPageState();
}

class _CustomSearchBeneficiaryPageState
    extends LocalizedState<CustomSearchBeneficiaryPage> {
  final TextEditingController searchController = TextEditingController();
  bool isProximityEnabled = false;
  int offset = 0;
  int limit = 10;

  double lat = 0.0;
  double long = 0.0;
  List<String> selectedFilters = [];

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
                if (RegistrationDeliverySingleton().beneficiaryType ==
                    BeneficiaryType.individual) {
                  blocWrapper.individualGlobalSearchBloc
                      .add(SearchHouseholdsEvent.individualGlobalSearch(
                          globalSearchParams: GlobalSearchParameters(
                    isProximityEnabled: isProximityEnabled,
                    latitude: lat,
                    longitude: long,
                    maxRadius: RegistrationDeliverySingleton().maxRadius,
                    nameSearch: searchController.text,
                    filter: selectedFilters,
                    offset: blocWrapper.individualGlobalSearchBloc.state.offset,
                    limit: blocWrapper.individualGlobalSearchBloc.state.limit,
                  )));
                } else {
                  blocWrapper.houseHoldGlobalSearchBloc
                      .add(SearchHouseholdsEvent.houseHoldGlobalSearch(
                          globalSearchParams: GlobalSearchParameters(
                    isProximityEnabled: isProximityEnabled,
                    latitude: lat,
                    longitude: long,
                    maxRadius: RegistrationDeliverySingleton().maxRadius,
                    nameSearch: searchController.text,
                    filter: selectedFilters,
                    offset: blocWrapper.houseHoldGlobalSearchBloc.state.offset,
                    limit: blocWrapper.houseHoldGlobalSearchBloc.state.limit,
                  )));
                }
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
                              RegistrationDeliverySingleton().beneficiaryType !=
                                      BeneficiaryType.individual
                                  ? i18.searchBeneficiary.statisticsLabelText
                                  : i18.searchBeneficiary
                                      .searchIndividualLabelText,
                            ),
                            style: theme.textTheme.displayMedium,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, locationState) {
                          return Column(
                            children: [
                              locationState.latitude != null
                                  ? Row(
                                      children: [
                                        Switch(
                                          value: isProximityEnabled,
                                          onChanged: (value) {
                                            searchController.clear();
                                            setState(() {
                                              isProximityEnabled = value;
                                              lat = locationState.latitude!;
                                              long = locationState.longitude!;
                                            });

                                            if (locationState.hasPermissions &&
                                                value &&
                                                locationState.latitude !=
                                                    null &&
                                                locationState.longitude !=
                                                    null &&
                                                RegistrationDeliverySingleton()
                                                        .maxRadius !=
                                                    null &&
                                                isProximityEnabled) {
                                              triggerGlobalSearchEvent();
                                            } else {
                                              blocWrapper.clearEvent();
                                              triggerGlobalSearchEvent();
                                            }
                                          },
                                        ),
                                        Text(
                                          localizations.translate(
                                            i18.searchBeneficiary
                                                .proximityLabel,
                                          ),
                                        ),
                                      ],
                                    )
                                  : const Offstage(),
                              DigitSearchBar(
                                controller: searchController,
                                hintText: localizations.translate(
                                  i18.searchBeneficiary
                                      .beneficiarySearchHintText,
                                ),
                                textCapitalization: TextCapitalization.words,
                                onChanged: (value) {
                                  if (value.isEmpty) {
                                    blocWrapper.clearEvent();
                                    triggerGlobalSearchEvent();
                                  }
                                  if (value.trim().length < 2 &&
                                      !isProximityEnabled) {
                                    blocWrapper.clearEvent();
                                  } else {
                                    blocWrapper.searchHouseholdsBloc.add(
                                      const SearchHouseholdsClearEvent(),
                                    );
                                  }
                                  triggerGlobalSearchEvent();
                                },
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(left: kPadding),
                                  child: DigitIconButton(
                                    textDirection: TextDirection.rtl,
                                    iconText: getFilterIconNLabel()['label'],
                                    icon: getFilterIconNLabel()['icon'],
                                    onPressed: () => showFilterDialog(),
                                  ),
                                ),
                              ),
                              selectedFilters.isNotEmpty
                                  ? Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: selectedFilters.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                  padding: const EdgeInsets.all(
                                                      kPadding / 2),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            kPadding / 2),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              const DigitColors()
                                                                  .cloudGray),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              kPadding / 2),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                            localizations.translate(
                                                                getStatus(
                                                                    selectedFilters[
                                                                        index])),
                                                            style: TextStyle(
                                                                color: const DigitColors()
                                                                    .davyGray)),
                                                        Text(
                                                            '(${searchHouseholdsState.householdMembers.length})',
                                                            style: TextStyle(
                                                                color: const DigitColors()
                                                                    .davyGray)),
                                                        const SizedBox(
                                                            width: kPadding),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              selectedFilters.remove(
                                                                  selectedFilters[
                                                                      index]);
                                                            });
                                                            blocWrapper
                                                                .clearEvent();
                                                            triggerGlobalSearchEvent();
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  const DigitColors()
                                                                      .davyGray,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          kPadding /
                                                                              2),
                                                            ),
                                                            child: Icon(
                                                              Icons.close,
                                                              color:
                                                                  const DigitColors()
                                                                      .white,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ));
                                            }),
                                      ),
                                    )
                                  : const Offstage(),
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

                          return Container(
                            margin: const EdgeInsets.only(bottom: kPadding),
                            child: CustomViewBeneficiaryCard(
                              distance: isProximityEnabled ? distance : null,
                              householdMember: i,
                              onOpenPressed: () async {
                                final scannerBloc =
                                    context.read<DigitScannerBloc>();

                                scannerBloc.add(
                                  const DigitScannerEvent.handleScanner(),
                                );

                                if (i.tasks != null &&
                                    i.tasks!.last.status ==
                                        Status.closeHousehold.name &&
                                    i.tasks!.isNotEmpty) {
                                  setState(() {
                                    selectedFilters = [];
                                  });
                                  blocWrapper.clearEvent();
                                  await context.router.push(
                                    BeneficiaryRegistrationWrapperRoute(
                                      initialState: BeneficiaryRegistrationState
                                          .editHousehold(
                                        householdModel: i.household!,
                                        individualModel: i.members!,
                                        registrationDate: DateTime.now(),
                                        projectBeneficiaryModel:
                                            i.projectBeneficiaries!.last,
                                        addressModel:
                                            i.headOfHousehold!.address!.last,
                                      ),
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
                                selectedFilters.clear();
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
          height: 70,
          child: Card(
            margin: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
              child: Column(
                children: [
                  DigitElevatedButton(
                    onPressed: searchHouseholdsState.searchQuery != null &&
                            searchHouseholdsState.searchQuery!.isNotEmpty
                        ? () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            context.read<DigitScannerBloc>().add(
                                  const DigitScannerEvent.handleScanner(),
                                );
                            context.router
                                .push(BeneficiaryRegistrationWrapperRoute(
                              initialState: BeneficiaryRegistrationCreateState(
                                searchQuery: searchHouseholdsState.searchQuery,
                              ),
                            ));

                            // final householdMemberWrapper =
                            //     searchHouseholdsState.householdMembers.first;
                            // final searchBlocState =
                            //     context.read<SearchHouseholdsBloc>().state;
                            // if (searchBlocState.householdMembers.isNotEmpty) {
                            //   await context.router.push(BeneficiaryWrapperRoute(
                            //     wrapper: searchBlocState.householdMembers.first,
                            //   ));
                            // }

                            searchController.clear();
                            selectedFilters = [];
                            blocWrapper.clearEvent();
                          }
                        : null,
                    child: Center(
                      child: Text(localizations.translate(
                        i18.searchBeneficiary.beneficiaryAddActionLabel,
                      )),
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

  showFilterDialog() async {
    var filters = await DigitDialog.show(context,
        options: DigitDialogOptions(
          isCloseIcon: true,
          barrierDismissible: true,
          content: StatusFilter(
            selectedFilters: selectedFilters,
            titleIcon: Icon(getFilterIconNLabel()['icon'],
                color: const DigitColors().burningOrange),
            titleText: getFilterIconNLabel()['label'],
            isCloseIcon: true,
          ),
        ));

    if (filters != null && filters.isNotEmpty) {
      setState(() {
        selectedFilters = [];
      });
      setState(() {
        selectedFilters.addAll(filters);
      });
      triggerGlobalSearchEvent();
    } else {
      setState(() {
        selectedFilters = [];
      });
      blocWrapper.clearEvent();
      triggerGlobalSearchEvent();
    }
  }

  void triggerGlobalSearchEvent() {
    blocWrapper.clearEvent();
    if (RegistrationDeliverySingleton().beneficiaryType ==
        BeneficiaryType.individual) {
      if (isProximityEnabled ||
          selectedFilters.isNotEmpty ||
          searchController.text.isNotEmpty ||
          searchController.text.length > 2) {
        blocWrapper.individualGlobalSearchBloc
            .add(SearchHouseholdsEvent.individualGlobalSearch(
                globalSearchParams: GlobalSearchParameters(
          isProximityEnabled: isProximityEnabled,
          latitude: lat,
          longitude: long,
          maxRadius: RegistrationDeliverySingleton().maxRadius,
          nameSearch: searchController.text,
          filter: selectedFilters,
          offset: offset,
          limit: limit,
        )));
      }
    } else {
      if (isProximityEnabled ||
          selectedFilters.isNotEmpty ||
          searchController.text.isNotEmpty) {
        blocWrapper.houseHoldGlobalSearchBloc
            .add(SearchHouseholdsEvent.houseHoldGlobalSearch(
                globalSearchParams: GlobalSearchParameters(
          isProximityEnabled: isProximityEnabled,
          latitude: lat,
          longitude: long,
          maxRadius: RegistrationDeliverySingleton().maxRadius,
          nameSearch: searchController.text.trim(),
          filter: selectedFilters,
          offset: offset,
          limit: limit,
        )));
      }
    }
  }

  String getStatus(String selectedFilter) {
    final statusMap = {
      Status.delivered.toValue(): Status.delivered,
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
