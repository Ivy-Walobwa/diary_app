// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class BlogPostData extends DataClass implements Insertable<BlogPostData> {
  final int id;
  final String name;
  final String content;
  final DateTime date;
  BlogPostData(
      {@required this.id, @required this.name, this.content, this.date});
  factory BlogPostData.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return BlogPostData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      content:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}content']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime>(date);
    }
    return map;
  }

  BlogPostCompanion toCompanion(bool nullToAbsent) {
    return BlogPostCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  factory BlogPostData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return BlogPostData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      content: serializer.fromJson<String>(json['content']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'content': serializer.toJson<String>(content),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  BlogPostData copyWith({int id, String name, String content, DateTime date}) =>
      BlogPostData(
        id: id ?? this.id,
        name: name ?? this.name,
        content: content ?? this.content,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('BlogPostData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(name.hashCode, $mrjc(content.hashCode, date.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is BlogPostData &&
          other.id == this.id &&
          other.name == this.name &&
          other.content == this.content &&
          other.date == this.date);
}

class BlogPostCompanion extends UpdateCompanion<BlogPostData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> content;
  final Value<DateTime> date;
  const BlogPostCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.content = const Value.absent(),
    this.date = const Value.absent(),
  });
  BlogPostCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    this.content = const Value.absent(),
    this.date = const Value.absent(),
  }) : name = Value(name);
  static Insertable<BlogPostData> custom({
    Expression<int> id,
    Expression<String> name,
    Expression<String> content,
    Expression<DateTime> date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (content != null) 'content': content,
      if (date != null) 'date': date,
    });
  }

  BlogPostCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> content,
      Value<DateTime> date}) {
    return BlogPostCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BlogPostCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('content: $content, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $BlogPostTable extends BlogPost
    with TableInfo<$BlogPostTable, BlogPostData> {
  final GeneratedDatabase _db;
  final String _alias;
  $BlogPostTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 1, maxTextLength: 80);
  }

  final VerificationMeta _contentMeta = const VerificationMeta('content');
  GeneratedTextColumn _content;
  @override
  GeneratedTextColumn get content => _content ??= _constructContent();
  GeneratedTextColumn _constructContent() {
    return GeneratedTextColumn(
      'content',
      $tableName,
      true,
    );
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  @override
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn(
      'date',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, content, date];
  @override
  $BlogPostTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'blog_post';
  @override
  final String actualTableName = 'blog_post';
  @override
  VerificationContext validateIntegrity(Insertable<BlogPostData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name'], _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content'], _contentMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date'], _dateMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BlogPostData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return BlogPostData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $BlogPostTable createAlias(String alias) {
    return $BlogPostTable(_db, alias);
  }
}

abstract class _$MoorDb extends GeneratedDatabase {
  _$MoorDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $BlogPostTable _blogPost;
  $BlogPostTable get blogPost => _blogPost ??= $BlogPostTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [blogPost];
}
