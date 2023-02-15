import 'package:auto_route/auto_route.dart';
import 'package:digit_components/blocs/location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:location/location.dart';

import '../blocs/household_details/household_details.dart';
import '../blocs/selected_households/selected_households.dart';
import '../blocs/sync/sync.dart';
import '../data/local_store/no_sql/schema/oplog.dart';
import '../data/network_manager.dart';
import '../models/entities/household_member.dart';
import '../models/entities/individual.dart';
import '../widgets/sidebar/side_bar.dart';

class AuthenticatedPageWrapper extends StatelessWidget {
  const AuthenticatedPageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Container(
        margin: const EdgeInsets.only(top: kToolbarHeight * 1.36),
        child: const Drawer(child: SideBar()),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final isar = context.read<Isar>();
              final bloc = SyncBloc(isar: isar)..add(const SyncRefreshEvent());

              isar.opLogs
                  .filter()
                  .isSyncedEqualTo(false)
                  .watch()
                  .listen((event) => bloc.add(const SyncRefreshEvent()));

              return bloc;
            },
          ),
          BlocProvider(
            create: (_) => LocationBloc(location: Location())
              ..add(const LoadLocationEvent()),
          ),
          BlocProvider(
            create: (_) => HouseholdDetailsBloc(const HouseholdDetailsState()),
          ),
          BlocProvider(
            create: (_) => SelectedHouseHoldsBloc(
              const SelectedHouseHoldsState(),
              context
                  .read<NetworkManager>()
                  .repository<HouseholdMemberModel, HouseholdMemberSearchModel>(
                    context,
                  ),
              context
                  .read<NetworkManager>()
                  .repository<IndividualModel, IndividualSearchModel>(
                    context,
                  ),
              context
                  .read<NetworkManager>()
                  .repository<IndividualModel, IndividualSearchModel>(
                    context,
                  ),
            ),
          ),
        ],
        child: const AutoRouter(),
      ),
    );
  }
}
