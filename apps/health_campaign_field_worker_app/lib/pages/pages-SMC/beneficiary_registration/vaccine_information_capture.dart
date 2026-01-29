import 'package:digit_components/digit_components.dart';
import 'package:digit_data_model/data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/app_initialization/app_initialization.dart';
import '../../../data/local_store/no_sql/schema/app_configuration.dart';
import '../../../router/app_router.dart';
import '../../../utils/utils_smc/utils_smc.dart';
import '../../../widgets/header/back_navigation_help_header.dart';
import '../../../widgets/localized.dart';

@RoutePage()
class VaccineInformationCapturePage extends LocalizedStatefulWidget {
  /// The individual/beneficiary whose vaccine information is being captured
  final IndividualModel? individual;

  const VaccineInformationCapturePage({
    super.key,
    super.appLocalizations,
    this.individual,
  });

  @override
  State<VaccineInformationCapturePage> createState() =>
      _VaccineInformationCapturePageState();
}

class _VaccineInformationCapturePageState
    extends LocalizedState<VaccineInformationCapturePage> {
  List<Vaccine>? vaccineData = [];
  List<VaccineGroup>? vaccineGroupData = [];
  VaccineGroup? applicableVaccineGroup;
  List<Vaccine>? applicableVaccines = [];
  Map<String, bool> vaccineSelection = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppInitializationBloc, AppInitializationState>(
        builder: (context, initState) {
      initState.maybeWhen(
        initialized: (appConfiguration, _, __) {
          // Use mdmsData to access the loaded MDMS data
          vaccineData = appConfiguration.vaccine;
          vaccineGroupData = appConfiguration.vaccineGroups;

          // Get the applicable vaccine group based on individual's age
          applicableVaccineGroup = getApplicableVaccineGroup(
            widget.individual,
            vaccineGroupData,
          );

          // Get vaccines for the applicable group
          if (applicableVaccineGroup != null) {
            applicableVaccines = getVaccinesForGroup(
              applicableVaccineGroup,
              vaccineData,
            );

            // Initialize vaccine selection map
            for (final vaccine in applicableVaccines!) {
              vaccineSelection.putIfAbsent(vaccine.code ?? '', () => false);
            }
          }
        },
        orElse: () => const Offstage(),
      );

      return Scaffold(
        body: ScrollableContent(
          header: BackNavigationHelpHeaderWidget(
            handleBack: () => Navigator.pop(context),
            showHelp: false,
            showcaseButton: null,
          ),
          enableFixedButton: true,
          footer: null,
          slivers: [
            // Beneficiary Age Info Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DigitCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Beneficiary Information',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      if (widget.individual?.name?.givenName != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Name: ${widget.individual?.name?.givenName}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      Text(
                        'Age: ${getVaccineAgeDisplayText(widget.individual)}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Vaccine Group Section
            if (applicableVaccineGroup != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DigitCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Applicable Vaccine Group',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: DigitTheme.instance.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getVaccineAgeGroupLabel(
                                  applicableVaccineGroup,
                                ),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 4),
                              if (applicableVaccineGroup?.code != null)
                                Text(
                                  'Code: ${applicableVaccineGroup?.code}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                        color: DigitTheme
                                            .instance.colorScheme.onSurface
                                            .withOpacity(0.6),
                                      ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            // Vaccines List Section
            if (applicableVaccines != null && applicableVaccines!.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DigitCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vaccines to Administer',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 16),
                        ..._buildVaccineList(context),
                      ],
                    ),
                  ),
                ),
              )
            else
              // No vaccines available section
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DigitCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        Icon(
                          Icons.info_outline,
                          size: 48,
                          color:
                              DigitTheme.instance.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No vaccines applicable for this age group',
                          textAlign: TextAlign.center,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: DigitTheme
                                        .instance.colorScheme.onSurfaceVariant,
                                  ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  /// Build the list of vaccines with checkboxes for selection
  List<Widget> _buildVaccineList(BuildContext context) {
    if (applicableVaccines == null || applicableVaccines!.isEmpty) {
      return [const SizedBox.shrink()];
    }

    return applicableVaccines!.map((vaccine) {
      final vaccineCode = vaccine.code ?? '';
      final vaccineName = vaccine.name ?? 'Unknown Vaccine';

      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: DigitTheme.instance.colorScheme.outlineVariant,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CheckboxListTile(
            title: Text(vaccineName),
            subtitle: Text(
              'Code: $vaccineCode',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: DigitTheme.instance.colorScheme.onSurface
                        .withOpacity(0.6),
                  ),
            ),
            value: vaccineSelection[vaccineCode] ?? false,
            onChanged: (bool? selected) {
              setState(() {
                vaccineSelection[vaccineCode] = selected ?? false;
              });
            },
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
          ),
        ),
      );
    }).toList();
  }
}
