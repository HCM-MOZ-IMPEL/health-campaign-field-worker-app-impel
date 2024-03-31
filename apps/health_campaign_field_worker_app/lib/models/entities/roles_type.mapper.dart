// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'roles_type.dart';

class RolesTypeMapper extends EnumMapper<RolesType> {
  RolesTypeMapper._();

  static RolesTypeMapper? _instance;
  static RolesTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = RolesTypeMapper._());
    }
    return _instance!;
  }

  static RolesType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  RolesType decode(dynamic value) {
    switch (value) {
      case "WAREHOUSE_MANAGER":
        return RolesType.warehouseManager;
      case "DISTRIBUTOR":
        return RolesType.distributor;
      case "REGISTRAR":
        return RolesType.registrar;
      case "SUPERVISOR":
        return RolesType.supervisor;
      case "NATIONAL_SUPERVISOR":
        return RolesType.nationalSupervisor;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(RolesType self) {
    switch (self) {
      case RolesType.warehouseManager:
        return "WAREHOUSE_MANAGER";
      case RolesType.distributor:
        return "DISTRIBUTOR";
      case RolesType.registrar:
        return "REGISTRAR";
      case RolesType.supervisor:
        return "SUPERVISOR";
      case RolesType.nationalSupervisor:
        return "NATIONAL_SUPERVISOR";
    }
  }
}

extension RolesTypeMapperExtension on RolesType {
  dynamic toValue() {
    RolesTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<RolesType>(this);
  }
}
