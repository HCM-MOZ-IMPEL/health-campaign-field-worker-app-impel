import 'package:auto_route/auto_route.dart';
import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';

import '../../../router/app_router.dart';
import '../../../widgets/header/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';
import 'package:registration_delivery/utils/i18_key_constants.dart' as i18;

@RoutePage()
class MorbidityControlPage extends LocalizedStatefulWidget {
  /// The individual/beneficiary whose morbidity information is being captured
  final IndividualModel? individual;
  final String? projectBeneficiaryClientReferenceId;

  const MorbidityControlPage({
    super.key,
    super.appLocalizations,
    this.individual,
    this.projectBeneficiaryClientReferenceId,
  });

  @override
  State<MorbidityControlPage> createState() => _MorbidityControlPageState();
}

class _MorbidityControlPageState extends LocalizedState<MorbidityControlPage> {
  // Hardcoded list of diseases - will be replaced with backend data later
  final List<String> _diseaseList = [
    'Tinha',
    'Sarna',
    'Tunguiasis',
    'Filariose linfática - Linfedema (inchaço da mama, braço ou pé)',
    'Filariose linfática - Hidrocele (escroto inchado)',
    'Tracoma folicular',
    'Tracoma Triquíase',
    'Suspeita de lepra',
  ];

  // Map to track selected diseases
  Map<String, bool> _diseaseSelection = {};

  @override
  void initState() {
    super.initState();
    // Initialize all diseases as unselected
    for (final disease in _diseaseList) {
      _diseaseSelection[disease] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollableContent(
        header: BackNavigationHelpHeaderWidget(
          handleBack: () => Navigator.pop(context),
          showHelp: false,
          showcaseButton: null,
        ),
        enableFixedButton: true,
        footer: DigitCard(
          margin: const EdgeInsets.fromLTRB(0, kPadding, 0, 0),
          padding: const EdgeInsets.fromLTRB(kPadding, 0, kPadding, 0),
          child: DigitElevatedButton(
            onPressed: () {
              _handleSubmit(context);
            },
            child: Center(
              child: Text(
                localizations.translate(i18.common.coreCommonSubmit),
              ),
            ),
          ),
        ),
        slivers: [
          SliverToBoxAdapter(
            child: DigitCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Controlo de Morbidade',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  // Question
                  Text(
                    'O beneficiário tem alguma das seguintes doenças?',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  // Disease checkboxes list
                  ..._buildDiseaseCheckboxList(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build the list of disease checkboxes
  List<Widget> _buildDiseaseCheckboxList(BuildContext context) {
    return _diseaseList.map((disease) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: _diseaseSelection[disease] ?? false,
            onChanged: (bool? selected) {
              setState(() {
                _diseaseSelection[disease] = selected ?? false;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(
                disease,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  /// Handle submit button press
  void _handleSubmit(BuildContext context) {
    // TODO: Save selected diseases and navigate to next screen
    // For now, navigate to EligibilityChecklistViewRoute
    if (context.mounted) {
      context.router.push(EligibilityChecklistViewRoute(
        projectBeneficiaryClientReferenceId:
            widget.projectBeneficiaryClientReferenceId,
        individual: widget.individual,
      ));
    }
  }
}
