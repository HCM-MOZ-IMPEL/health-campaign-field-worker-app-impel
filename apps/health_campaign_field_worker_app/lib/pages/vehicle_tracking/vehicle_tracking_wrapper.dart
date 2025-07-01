import 'package:auto_route/auto_route.dart';
import 'package:digit_data_model/models/entities/individual.dart';
import 'package:digit_data_model/models/entities/product_variant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:registration_delivery/blocs/search_households/household_global_seach.dart';
import 'package:registration_delivery/blocs/search_households/individual_global_search.dart';
import 'package:registration_delivery/blocs/search_households/search_bloc_common_wrapper.dart';
import 'package:registration_delivery/blocs/search_households/search_households.dart';
import 'package:registration_delivery/blocs/search_households/tag_by_search.dart';
import 'package:registration_delivery/data/repositories/local/household_global_search.dart';
import 'package:registration_delivery/data/repositories/local/individual_global_search.dart';
import 'package:registration_delivery/data/repositories/local/registration_delivery_address.dart';
import 'package:registration_delivery/models/entities/household.dart';
import 'package:registration_delivery/models/entities/household_member.dart';
import 'package:registration_delivery/models/entities/project_beneficiary.dart';
import 'package:registration_delivery/models/entities/referral.dart';
import 'package:registration_delivery/models/entities/side_effect.dart';
import 'package:registration_delivery/models/entities/task.dart';
import 'package:registration_delivery/utils/extensions/extensions.dart';
import 'package:registration_delivery/utils/utils.dart';

import '../../blocs/vehicle_tracking/search_vehicle_bloc_common_wrapper.dart';
import '../../blocs/vehicle_tracking/search_vehicles.dart';

@RoutePage()
class VehicleTrackingWrapperPage extends StatelessWidget {
  const VehicleTrackingWrapperPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return SearchVehiclesBloc(
              userUid: RegistrationDeliverySingleton().loggedInUserUuid!,
              projectId: RegistrationDeliverySingleton().projectId!,
              individual: context
                  .repository<IndividualModel, IndividualSearchModel>(context),
              productVariantDataRepository: context.repository<
                  ProductVariantModel, ProductVariantSearchModel>(context),
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return SearchVehicleBlocWrapper(
              searchVehiclesBloc: context.read<SearchVehiclesBloc>(),
            );
          },
        ),
      ],
      child: const AutoRouter(),
    );
  }
}
