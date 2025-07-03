import 'package:dart_mappable/dart_mappable.dart';

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum TripActions {
  @MappableValue("start")
  start,
  @MappableValue("end")
  end,
}
