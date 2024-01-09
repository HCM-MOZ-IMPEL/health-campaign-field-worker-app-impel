// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'absent_attendee.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAbsentAttendeeCollection on Isar {
  IsarCollection<AbsentAttendee> get absentAttendees => this.collection();
}

const AbsentAttendeeSchema = CollectionSchema(
  name: r'AbsentAttendee',
  id: 3385487881449857,
  properties: {
    r'currentDate': PropertySchema(
      id: 0,
      name: r'currentDate',
      type: IsarType.long,
    ),
    r'entryTime': PropertySchema(
      id: 1,
      name: r'entryTime',
      type: IsarType.long,
    ),
    r'eventEndDate': PropertySchema(
      id: 2,
      name: r'eventEndDate',
      type: IsarType.long,
    ),
    r'eventStartDate': PropertySchema(
      id: 3,
      name: r'eventStartDate',
      type: IsarType.long,
    ),
    r'exitTime': PropertySchema(
      id: 4,
      name: r'exitTime',
      type: IsarType.long,
    ),
    r'individualId': PropertySchema(
      id: 5,
      name: r'individualId',
      type: IsarType.string,
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'projectId': PropertySchema(
      id: 7,
      name: r'projectId',
      type: IsarType.string,
    ),
    r'registerId': PropertySchema(
      id: 8,
      name: r'registerId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 9,
      name: r'status',
      type: IsarType.long,
    ),
    r'tenantId': PropertySchema(
      id: 10,
      name: r'tenantId',
      type: IsarType.string,
    ),
    r'userName': PropertySchema(
      id: 11,
      name: r'userName',
      type: IsarType.string,
    )
  },
  estimateSize: _absentAttendeeEstimateSize,
  serialize: _absentAttendeeSerialize,
  deserialize: _absentAttendeeDeserialize,
  deserializeProp: _absentAttendeeDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _absentAttendeeGetId,
  getLinks: _absentAttendeeGetLinks,
  attach: _absentAttendeeAttach,
  version: '3.1.0',
);

int _absentAttendeeEstimateSize(
  AbsentAttendee object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.individualId.length * 3;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.projectId.length * 3;
  bytesCount += 3 + object.registerId.length * 3;
  bytesCount += 3 + object.tenantId.length * 3;
  bytesCount += 3 + object.userName.length * 3;
  return bytesCount;
}

void _absentAttendeeSerialize(
  AbsentAttendee object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.currentDate);
  writer.writeLong(offsets[1], object.entryTime);
  writer.writeLong(offsets[2], object.eventEndDate);
  writer.writeLong(offsets[3], object.eventStartDate);
  writer.writeLong(offsets[4], object.exitTime);
  writer.writeString(offsets[5], object.individualId);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.projectId);
  writer.writeString(offsets[8], object.registerId);
  writer.writeLong(offsets[9], object.status);
  writer.writeString(offsets[10], object.tenantId);
  writer.writeString(offsets[11], object.userName);
}

AbsentAttendee _absentAttendeeDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AbsentAttendee();
  object.currentDate = reader.readLong(offsets[0]);
  object.entryTime = reader.readLong(offsets[1]);
  object.eventEndDate = reader.readLong(offsets[2]);
  object.eventStartDate = reader.readLong(offsets[3]);
  object.exitTime = reader.readLong(offsets[4]);
  object.id = id;
  object.individualId = reader.readString(offsets[5]);
  object.name = reader.readString(offsets[6]);
  object.projectId = reader.readString(offsets[7]);
  object.registerId = reader.readString(offsets[8]);
  object.status = reader.readLong(offsets[9]);
  object.tenantId = reader.readString(offsets[10]);
  object.userName = reader.readString(offsets[11]);
  return object;
}

P _absentAttendeeDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _absentAttendeeGetId(AbsentAttendee object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _absentAttendeeGetLinks(AbsentAttendee object) {
  return [];
}

void _absentAttendeeAttach(
    IsarCollection<dynamic> col, Id id, AbsentAttendee object) {
  object.id = id;
}

extension AbsentAttendeeQueryWhereSort
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QWhere> {
  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AbsentAttendeeQueryWhere
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QWhereClause> {
  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AbsentAttendeeQueryFilter
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QFilterCondition> {
  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      currentDateEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      currentDateGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      currentDateLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      currentDateBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      entryTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entryTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      entryTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entryTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      entryTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entryTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      entryTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entryTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      eventEndDateEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventEndDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      eventEndDateGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventEndDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      eventEndDateLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventEndDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      eventEndDateBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventEndDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      eventStartDateEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'eventStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      eventStartDateGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'eventStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      eventStartDateLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'eventStartDate',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      eventStartDateBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'eventStartDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      exitTimeEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'exitTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      exitTimeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'exitTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      exitTimeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'exitTime',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      exitTimeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'exitTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'individualId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'individualId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'individualId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'individualId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'individualId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'individualId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'individualId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'individualId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'individualId',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      individualIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'individualId',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'projectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'projectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'projectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'projectId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'projectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'projectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'projectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'projectId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'projectId',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      projectIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'projectId',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'registerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'registerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'registerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'registerId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'registerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'registerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'registerId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'registerId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'registerId',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      registerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'registerId',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      statusEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      statusGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      statusLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      statusBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tenantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tenantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tenantId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tenantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tenantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tenantId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tenantId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tenantId',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      tenantIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tenantId',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'userName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'userName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'userName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'userName',
        value: '',
      ));
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterFilterCondition>
      userNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'userName',
        value: '',
      ));
    });
  }
}

extension AbsentAttendeeQueryObject
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QFilterCondition> {}

extension AbsentAttendeeQueryLinks
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QFilterCondition> {}

extension AbsentAttendeeQuerySortBy
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QSortBy> {
  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByCurrentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDate', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByCurrentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDate', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> sortByEntryTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryTime', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByEntryTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryTime', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByEventEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventEndDate', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByEventEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventEndDate', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByEventStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventStartDate', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByEventStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventStartDate', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> sortByExitTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exitTime', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByExitTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exitTime', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByIndividualId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'individualId', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByIndividualIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'individualId', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> sortByProjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectId', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByProjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectId', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByRegisterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'registerId', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByRegisterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'registerId', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> sortByTenantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenantId', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByTenantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenantId', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> sortByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      sortByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension AbsentAttendeeQuerySortThenBy
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QSortThenBy> {
  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByCurrentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDate', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByCurrentDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentDate', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByEntryTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryTime', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByEntryTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entryTime', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByEventEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventEndDate', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByEventEndDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventEndDate', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByEventStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventStartDate', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByEventStartDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'eventStartDate', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByExitTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exitTime', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByExitTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'exitTime', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByIndividualId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'individualId', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByIndividualIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'individualId', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByProjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectId', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByProjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'projectId', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByRegisterId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'registerId', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByRegisterIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'registerId', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByTenantId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenantId', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByTenantIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tenantId', Sort.desc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy> thenByUserName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.asc);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QAfterSortBy>
      thenByUserNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'userName', Sort.desc);
    });
  }
}

extension AbsentAttendeeQueryWhereDistinct
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct> {
  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct>
      distinctByCurrentDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentDate');
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct>
      distinctByEntryTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entryTime');
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct>
      distinctByEventEndDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventEndDate');
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct>
      distinctByEventStartDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'eventStartDate');
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct> distinctByExitTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'exitTime');
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct>
      distinctByIndividualId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'individualId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct> distinctByProjectId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'projectId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct> distinctByRegisterId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'registerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct> distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct> distinctByTenantId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tenantId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AbsentAttendee, AbsentAttendee, QDistinct> distinctByUserName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'userName', caseSensitive: caseSensitive);
    });
  }
}

extension AbsentAttendeeQueryProperty
    on QueryBuilder<AbsentAttendee, AbsentAttendee, QQueryProperty> {
  QueryBuilder<AbsentAttendee, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AbsentAttendee, int, QQueryOperations> currentDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentDate');
    });
  }

  QueryBuilder<AbsentAttendee, int, QQueryOperations> entryTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entryTime');
    });
  }

  QueryBuilder<AbsentAttendee, int, QQueryOperations> eventEndDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventEndDate');
    });
  }

  QueryBuilder<AbsentAttendee, int, QQueryOperations> eventStartDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'eventStartDate');
    });
  }

  QueryBuilder<AbsentAttendee, int, QQueryOperations> exitTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'exitTime');
    });
  }

  QueryBuilder<AbsentAttendee, String, QQueryOperations>
      individualIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'individualId');
    });
  }

  QueryBuilder<AbsentAttendee, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<AbsentAttendee, String, QQueryOperations> projectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'projectId');
    });
  }

  QueryBuilder<AbsentAttendee, String, QQueryOperations> registerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'registerId');
    });
  }

  QueryBuilder<AbsentAttendee, int, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<AbsentAttendee, String, QQueryOperations> tenantIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tenantId');
    });
  }

  QueryBuilder<AbsentAttendee, String, QQueryOperations> userNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'userName');
    });
  }
}
