import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digit_data_model/data_model.dart';

import 'package:survey_form/models/entities/service.dart';
import 'package:survey_form/models/entities/service_definition.dart';

import '../../blocs/custom_service_bloc.dart';
import '../../blocs/custom_service_definition_bloc.dart';
import '../../utils/extensions/extensions.dart';
import '../../widgets/boundary_selection_wrapper.dart';

@RoutePage()
class CustomChecklistWrapperPage extends StatelessWidget
    implements AutoRouteWrapper {
  final bool isEditing;

  const CustomChecklistWrapperPage({
    super.key,
    this.isEditing = false,
  });

  @override
  Widget build(BuildContext context) {
    return const BoundarySelectionWrapper(
      child: AutoRouter(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final serviceDefinition = context
        .repository<ServiceDefinitionModel, ServiceDefinitionSearchModel>();

    final service = context.repository<ServiceModel, ServiceSearchModel>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ServiceDefinitionBloc(
            const ServiceDefinitionEmptyState(),
            serviceDefinitionDataRepository: serviceDefinition,
          )..add(const ServiceDefinitionFetchEvent()),
        ),
        BlocProvider(
          create: (_) => ServiceBloc(
            const ServiceEmptyState(),
            serviceDataRepository: service,
          ),
        ),
      ],
      child: this,
    );
  }
}
