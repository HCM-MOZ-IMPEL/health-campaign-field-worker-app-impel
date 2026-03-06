// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'project_types.dart';

class ProjectTypesMapper extends EnumMapper<ProjectTypes> {
  ProjectTypesMapper._();

  static ProjectTypesMapper? _instance;
  static ProjectTypesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProjectTypesMapper._());
    }
    return _instance!;
  }

  static ProjectTypes fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ProjectTypes decode(dynamic value) {
    switch (value) {
      case "IRS":
        return ProjectTypes.irs;
      case "SMC-Moz26":
        return ProjectTypes.smc;
      case "LLIN-SMC":
        return ProjectTypes.smcAndBednet;
      case "Oncho":
        return ProjectTypes.smcAndOncho;
      case "LLIN-Moz":
        return ProjectTypes.bednet;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ProjectTypes self) {
    switch (self) {
      case ProjectTypes.irs:
        return "IRS";
      case ProjectTypes.smc:
        return "SMC-Moz26";
      case ProjectTypes.smcAndBednet:
        return "LLIN-SMC";
      case ProjectTypes.smcAndOncho:
        return "Oncho";
      case ProjectTypes.bednet:
        return "LLIN-Moz";
    }
  }
}

extension ProjectTypesMapperExtension on ProjectTypes {
  dynamic toValue() {
    ProjectTypesMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ProjectTypes>(this);
  }
}
