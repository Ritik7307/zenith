// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subject.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetSubjectCollection on Isar {
  IsarCollection<Subject> get subjects => this.collection();
}

const SubjectSchema = CollectionSchema(
  name: r'Subject',
  id: 7648000959054204885,
  properties: {
    r'attendedClasses': PropertySchema(
      id: 0,
      name: r'attendedClasses',
      type: IsarType.long,
    ),
    r'currentPercentage': PropertySchema(
      id: 1,
      name: r'currentPercentage',
      type: IsarType.double,
    ),
    r'name': PropertySchema(
      id: 2,
      name: r'name',
      type: IsarType.string,
    ),
    r'records': PropertySchema(
      id: 3,
      name: r'records',
      type: IsarType.objectList,
      target: r'AttendanceRecord',
    ),
    r'targetPercentage': PropertySchema(
      id: 4,
      name: r'targetPercentage',
      type: IsarType.long,
    ),
    r'totalClasses': PropertySchema(
      id: 5,
      name: r'totalClasses',
      type: IsarType.long,
    )
  },
  estimateSize: _subjectEstimateSize,
  serialize: _subjectSerialize,
  deserialize: _subjectDeserialize,
  deserializeProp: _subjectDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {r'AttendanceRecord': AttendanceRecordSchema},
  getId: _subjectGetId,
  getLinks: _subjectGetLinks,
  attach: _subjectAttach,
  version: '3.1.0+1',
);

int _subjectEstimateSize(
  Subject object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.records.length * 3;
  {
    final offsets = allOffsets[AttendanceRecord]!;
    for (var i = 0; i < object.records.length; i++) {
      final value = object.records[i];
      bytesCount +=
          AttendanceRecordSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _subjectSerialize(
  Subject object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.attendedClasses);
  writer.writeDouble(offsets[1], object.currentPercentage);
  writer.writeString(offsets[2], object.name);
  writer.writeObjectList<AttendanceRecord>(
    offsets[3],
    allOffsets,
    AttendanceRecordSchema.serialize,
    object.records,
  );
  writer.writeLong(offsets[4], object.targetPercentage);
  writer.writeLong(offsets[5], object.totalClasses);
}

Subject _subjectDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Subject();
  object.id = id;
  object.name = reader.readString(offsets[2]);
  object.records = reader.readObjectList<AttendanceRecord>(
        offsets[3],
        AttendanceRecordSchema.deserialize,
        allOffsets,
        AttendanceRecord(),
      ) ??
      [];
  object.targetPercentage = reader.readLong(offsets[4]);
  return object;
}

P _subjectDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDouble(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readObjectList<AttendanceRecord>(
            offset,
            AttendanceRecordSchema.deserialize,
            allOffsets,
            AttendanceRecord(),
          ) ??
          []) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _subjectGetId(Subject object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _subjectGetLinks(Subject object) {
  return [];
}

void _subjectAttach(IsarCollection<dynamic> col, Id id, Subject object) {
  object.id = id;
}

extension SubjectQueryWhereSort on QueryBuilder<Subject, Subject, QWhere> {
  QueryBuilder<Subject, Subject, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension SubjectQueryWhere on QueryBuilder<Subject, Subject, QWhereClause> {
  QueryBuilder<Subject, Subject, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Subject, Subject, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Subject, Subject, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Subject, Subject, QAfterWhereClause> idBetween(
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

extension SubjectQueryFilter
    on QueryBuilder<Subject, Subject, QFilterCondition> {
  QueryBuilder<Subject, Subject, QAfterFilterCondition> attendedClassesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attendedClasses',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition>
      attendedClassesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attendedClasses',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> attendedClassesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attendedClasses',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> attendedClassesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attendedClasses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition>
      currentPercentageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition>
      currentPercentageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition>
      currentPercentageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentPercentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition>
      currentPercentageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentPercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameEqualTo(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameGreaterThan(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameLessThan(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameBetween(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameStartsWith(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameEndsWith(
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

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> recordsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> recordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> recordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> recordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition>
      recordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> recordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> targetPercentageEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'targetPercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition>
      targetPercentageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'targetPercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition>
      targetPercentageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'targetPercentage',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> targetPercentageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'targetPercentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> totalClassesEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalClasses',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> totalClassesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalClasses',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> totalClassesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalClasses',
        value: value,
      ));
    });
  }

  QueryBuilder<Subject, Subject, QAfterFilterCondition> totalClassesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalClasses',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension SubjectQueryObject
    on QueryBuilder<Subject, Subject, QFilterCondition> {
  QueryBuilder<Subject, Subject, QAfterFilterCondition> recordsElement(
      FilterQuery<AttendanceRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'records');
    });
  }
}

extension SubjectQueryLinks
    on QueryBuilder<Subject, Subject, QFilterCondition> {}

extension SubjectQuerySortBy on QueryBuilder<Subject, Subject, QSortBy> {
  QueryBuilder<Subject, Subject, QAfterSortBy> sortByAttendedClasses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attendedClasses', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByAttendedClassesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attendedClasses', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByCurrentPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPercentage', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByCurrentPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPercentage', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByTargetPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetPercentage', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByTargetPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetPercentage', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByTotalClasses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalClasses', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> sortByTotalClassesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalClasses', Sort.desc);
    });
  }
}

extension SubjectQuerySortThenBy
    on QueryBuilder<Subject, Subject, QSortThenBy> {
  QueryBuilder<Subject, Subject, QAfterSortBy> thenByAttendedClasses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attendedClasses', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByAttendedClassesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attendedClasses', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByCurrentPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPercentage', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByCurrentPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentPercentage', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByTargetPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetPercentage', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByTargetPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'targetPercentage', Sort.desc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByTotalClasses() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalClasses', Sort.asc);
    });
  }

  QueryBuilder<Subject, Subject, QAfterSortBy> thenByTotalClassesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalClasses', Sort.desc);
    });
  }
}

extension SubjectQueryWhereDistinct
    on QueryBuilder<Subject, Subject, QDistinct> {
  QueryBuilder<Subject, Subject, QDistinct> distinctByAttendedClasses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attendedClasses');
    });
  }

  QueryBuilder<Subject, Subject, QDistinct> distinctByCurrentPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentPercentage');
    });
  }

  QueryBuilder<Subject, Subject, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Subject, Subject, QDistinct> distinctByTargetPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'targetPercentage');
    });
  }

  QueryBuilder<Subject, Subject, QDistinct> distinctByTotalClasses() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalClasses');
    });
  }
}

extension SubjectQueryProperty
    on QueryBuilder<Subject, Subject, QQueryProperty> {
  QueryBuilder<Subject, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Subject, int, QQueryOperations> attendedClassesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attendedClasses');
    });
  }

  QueryBuilder<Subject, double, QQueryOperations> currentPercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentPercentage');
    });
  }

  QueryBuilder<Subject, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Subject, List<AttendanceRecord>, QQueryOperations>
      recordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'records');
    });
  }

  QueryBuilder<Subject, int, QQueryOperations> targetPercentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'targetPercentage');
    });
  }

  QueryBuilder<Subject, int, QQueryOperations> totalClassesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalClasses');
    });
  }
}
