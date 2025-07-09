import 'package:dart_mappable/dart_mappable.dart';

part 'trip_actions.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum TripActions {
  @MappableValue("start")
  start,
  @MappableValue("end")
  end,
}
