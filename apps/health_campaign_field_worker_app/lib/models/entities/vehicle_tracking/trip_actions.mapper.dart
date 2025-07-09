// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'trip_actions.dart';

class TripActionsMapper extends EnumMapper<TripActions> {
  TripActionsMapper._();

  static TripActionsMapper? _instance;
  static TripActionsMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TripActionsMapper._());
    }
    return _instance!;
  }

  static TripActions fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  TripActions decode(dynamic value) {
    switch (value) {
      case "start":
        return TripActions.start;
      case "end":
        return TripActions.end;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(TripActions self) {
    switch (self) {
      case TripActions.start:
        return "start";
      case TripActions.end:
        return "end";
    }
  }
}

extension TripActionsMapperExtension on TripActions {
  dynamic toValue() {
    TripActionsMapper.ensureInitialized();
    return MapperContainer.globals.toValue<TripActions>(this);
  }
}
