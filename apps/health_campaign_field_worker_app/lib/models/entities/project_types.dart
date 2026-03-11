// Generated using mason. Do not modify by hand
import 'package:dart_mappable/dart_mappable.dart';

part 'project_types.mapper.dart';

@MappableEnum(caseStyle: CaseStyle.upperCase)
enum ProjectTypes {
  @MappableValue("IRS")
  irs,
  @MappableValue("SMC-Moz26")
  smc,
  @MappableValue("LLIN-SMC")
  smcAndBednet,
  @MappableValue("Oncho")
  smcAndOncho,
  @MappableValue("LLIN-Moz")
  bednet,
  ;
}
