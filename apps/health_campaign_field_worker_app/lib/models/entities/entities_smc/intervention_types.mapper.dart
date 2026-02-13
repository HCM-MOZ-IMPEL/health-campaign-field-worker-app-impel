// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'intervention_types.dart';

class InterventionTypesMapper extends EnumMapper<InterventionTypes> {
  InterventionTypesMapper._();

  static InterventionTypesMapper? _instance;
  static InterventionTypesMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InterventionTypesMapper._());
    }
    return _instance!;
  }

  static InterventionTypes fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  InterventionTypes decode(dynamic value) {
    switch (value) {
      case "smc":
        return InterventionTypes.smc;
      case "oncho":
        return InterventionTypes.oncho;
      case "bednet":
        return InterventionTypes.bednet;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(InterventionTypes self) {
    switch (self) {
      case InterventionTypes.smc:
        return "smc";
      case InterventionTypes.oncho:
        return "oncho";
      case InterventionTypes.bednet:
        return "bednet";
    }
  }
}

extension InterventionTypesMapperExtension on InterventionTypes {
  dynamic toValue() {
    InterventionTypesMapper.ensureInitialized();
    return MapperContainer.globals.toValue<InterventionTypes>(this);
  }
}
