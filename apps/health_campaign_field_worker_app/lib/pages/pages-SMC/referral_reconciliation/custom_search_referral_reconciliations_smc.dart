// import 'package:auto_route/auto_route.dart';
// import 'package:digit_components/digit_components.dart';
// import 'package:digit_data_model/data_model.dart';
// import 'package:digit_scanner/blocs/scanner.dart';
// import 'package:digit_scanner/router/digit_scanner_router.gm.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:referral_reconciliation/blocs/search_referral_reconciliations.dart';
// import 'package:referral_reconciliation/models/entities/hf_referral.dart';
// import 'package:referral_reconciliation/router/referral_reconciliation_router.gm.dart';
// import 'package:referral_reconciliation/utils/extensions/extensions.dart';
// import 'package:referral_reconciliation/utils/utils.dart';
// import 'package:referral_reconciliation/widgets/view_referral_card.dart';
// import 'package:survey_form/survey_form.dart';

// import '../../../widgets/header/back_navigation_help_header.dart';
// import '../../../widgets/localized.dart';

// import '../../../utils/i18_key_constants.dart' as i18;

// @RoutePage()
// class CustomSearchReferralReconciliationsSMCPage
//     extends LocalizedStatefulWidget {
//   const CustomSearchReferralReconciliationsSMCPage({
//     super.key,
//     super.appLocalizations,
//   });

//   @override
//   State<CustomSearchReferralReconciliationsSMCPage> createState() =>
//       _SearchReferralReconciliationsPageState();
// }

// class _SearchReferralReconciliationsPageState
//     extends LocalizedState<CustomSearchReferralReconciliationsSMCPage> {
//   final TextEditingController searchController = TextEditingController();
//   bool isProximityEnabled = false;
//   SearchReferralsBloc? searchReferralsBloc;

//   @override
//   void initState() {
//     searchReferralsBloc = SearchReferralsBloc(
//       const SearchReferralsState(),
//       referralReconDataRepository:
//           context.repository<HFReferralModel, HFReferralSearchModel>(context),
//     );
//     context.read<DigitScannerBloc>().add(
//           const DigitScannerEvent.handleScanner(),
//         );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return KeyboardVisibilityBuilder(
//         builder: (context, isKeyboardVisible) => BlocProvider<
//                 SearchReferralsBloc>(
//             create: (context) => searchReferralsBloc!
//               ..add(
//                 const SearchReferralsClearEvent(),
//               ),
//             child: Scaffold(
//               body: BlocListener<DigitScannerBloc, DigitScannerState>(
//                   listener: (context, scannerState) {
//                     if (scannerState.qrCodes.isNotEmpty) {
//                       context
//                           .read<SearchReferralsBloc>()
//                           .add(SearchReferralsEvent.searchByTag(
//                             tag: scannerState.qrCodes.last,
//                           ));
//                     }
//                   },
//                   child: BlocProvider(
//                       create: (_) => ServiceBloc(
//                             const ServiceEmptyState(),
//                             serviceDataRepository: context.repository<
//                                 ServiceModel, ServiceSearchModel>(context),
//                           ),
//                       child: BlocBuilder<SearchReferralsBloc,
//                           SearchReferralsState>(
//                         builder: (context, searchState) {
//                           return ScrollableContent(
//                             header: const Column(children: [
//                               BackNavigationHelpHeaderWidget(
//                                 showHelp: false,
//                               ),
//                             ]),
//                             slivers: [
//                               SliverToBoxAdapter(
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(kPadding),
//                                   child: Column(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.all(kPadding),
//                                         child: Align(
//                                           alignment: Alignment.topLeft,
//                                           child: Text(
//                                             localizations.translate(
//                                               i18.referralReconciliation
//                                                   .searchReferralsHeader,
//                                             ),
//                                             style:
//                                                 theme.textTheme.displayMedium,
//                                             textAlign: TextAlign.left,
//                                           ),
//                                         ),
//                                       ),
//                                       Column(
//                                         children: [
//                                           DigitSearchBar(
//                                             controller: searchController,
//                                             hintText: localizations.translate(
//                                               i18.referralReconciliation
//                                                   .referralSearchHintText,
//                                             ),
//                                             textCapitalization:
//                                                 TextCapitalization.words,
//                                             onChanged: (value) {
//                                               final bloc = context
//                                                   .read<SearchReferralsBloc>();
//                                               if (value.trim().length < 2) {
//                                                 bloc.add(
//                                                   const SearchReferralsClearEvent(),
//                                                 );

//                                                 return;
//                                               } else {
//                                                 bloc.add(
//                                                     SearchReferralsByNameEvent(
//                                                   searchText: value.trim(),
//                                                 ));
//                                               }
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                       const SizedBox(height: kPadding * 2),
//                                       if (searchState.resultsNotFound)
//                                         DigitInfoCard(
//                                           description: localizations.translate(
//                                             i18.referralReconciliation
//                                                 .referralInfoDescription,
//                                           ),
//                                           title: localizations.translate(
//                                             i18.referralReconciliation
//                                                 .beneficiaryInfoTitle,
//                                           ),
//                                         ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SliverList(
//                                 delegate: SliverChildBuilderDelegate(
//                                   (ctx, index) {
//                                     final i =
//                                         searchState.referrals.elementAt(index);

//                                     return Container(
//                                       margin: const EdgeInsets.only(
//                                           bottom: kPadding),
//                                       child: ViewReferralCard(
//                                         hfReferralModel: i,
//                                         onOpenPressed: () {
//                                           context.read<ServiceBloc>().add(
//                                                 ServiceSearchEvent(
//                                                   serviceSearchModel:
//                                                       ServiceSearchModel(
//                                                     clientId:
//                                                         i.clientReferenceId,
//                                                   ),
//                                                 ),
//                                               );
//                                           context.router.push(
//                                             HFCreateReferralWrapperRoute(
//                                               viewOnly: true,
//                                               referralReconciliation: i,
//                                               projectId:
//                                                   ReferralReconSingleton()
//                                                       .projectId,
//                                               cycles: ReferralReconSingleton()
//                                                   .cycles,
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   },
//                                   childCount: searchState.referrals.length,
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ))),
//               bottomNavigationBar: SizedBox(
//                 height: 75,
//                 child: Card(
//                   margin: const EdgeInsets.all(0),
//                   child: Container(
//                     padding:
//                         const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
//                     child:
//                         BlocBuilder<SearchReferralsBloc, SearchReferralsState>(
//                       builder: (context, state) {
//                         final router = context.router;

//                         VoidCallback? onPressed;

//                         onPressed = state.loading ||
//                                 state.searchQuery == null ||
//                                 (state.searchQuery ?? '').length < 2
//                             ? null
//                             : () {
//                                 FocusManager.instance.primaryFocus?.unfocus();
//                                 final bloc =
//                                     context.read<SearchReferralsBloc>();
//                                 router.push(
//                                   HFCreateReferralWrapperRoute(
//                                     viewOnly: false,
//                                     referralReconciliation: HFReferralModel(
//                                       clientReferenceId: IdGen.i.identifier,
//                                       name: state.searchQuery,
//                                       beneficiaryId: state.tag,
//                                     ),
//                                     projectId:
//                                         ReferralReconSingleton().projectId,
//                                     cycles: ReferralReconSingleton().cycles,
//                                   ),
//                                 );
//                                 searchController.clear();
//                                 bloc.add(
//                                   const SearchReferralsClearEvent(),
//                                 );
//                               };

//                         return DigitElevatedButton(
//                           onPressed: onPressed,
//                           child: Center(
//                             child: Text(localizations.translate(
//                               i18.referralReconciliation.createReferralLabel,
//                             )),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             )));
//   }
// }
