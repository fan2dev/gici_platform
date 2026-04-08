/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class SchoolCalendarEvent implements _i1.SerializableModel {
  SchoolCalendarEvent._({
    this.id,
    required this.organizationId,
    required this.title,
    this.description,
    required this.eventDate,
    this.endDate,
    required this.eventType,
    required this.isRecurring,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
  });

  factory SchoolCalendarEvent({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String title,
    String? description,
    required DateTime eventDate,
    DateTime? endDate,
    required String eventType,
    required bool isRecurring,
    required _i1.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) = _SchoolCalendarEventImpl;

  factory SchoolCalendarEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return SchoolCalendarEvent(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      organizationId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['organizationId']),
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      eventDate:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['eventDate']),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
      eventType: jsonSerialization['eventType'] as String,
      isRecurring: jsonSerialization['isRecurring'] as bool,
      createdByUserId: _i1.UuidValueJsonExtension.fromJson(
          jsonSerialization['createdByUserId']),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      deletedAt: jsonSerialization['deletedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['deletedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  _i1.UuidValue? id;

  _i1.UuidValue organizationId;

  String title;

  String? description;

  DateTime eventDate;

  DateTime? endDate;

  String eventType;

  bool isRecurring;

  _i1.UuidValue createdByUserId;

  DateTime createdAt;

  DateTime updatedAt;

  DateTime? deletedAt;

  /// Returns a shallow copy of this [SchoolCalendarEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SchoolCalendarEvent copyWith({
    _i1.UuidValue? id,
    _i1.UuidValue? organizationId,
    String? title,
    String? description,
    DateTime? eventDate,
    DateTime? endDate,
    String? eventType,
    bool? isRecurring,
    _i1.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id?.toJson(),
      'organizationId': organizationId.toJson(),
      'title': title,
      if (description != null) 'description': description,
      'eventDate': eventDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
      'eventType': eventType,
      'isRecurring': isRecurring,
      'createdByUserId': createdByUserId.toJson(),
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
      if (deletedAt != null) 'deletedAt': deletedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SchoolCalendarEventImpl extends SchoolCalendarEvent {
  _SchoolCalendarEventImpl({
    _i1.UuidValue? id,
    required _i1.UuidValue organizationId,
    required String title,
    String? description,
    required DateTime eventDate,
    DateTime? endDate,
    required String eventType,
    required bool isRecurring,
    required _i1.UuidValue createdByUserId,
    required DateTime createdAt,
    required DateTime updatedAt,
    DateTime? deletedAt,
  }) : super._(
          id: id,
          organizationId: organizationId,
          title: title,
          description: description,
          eventDate: eventDate,
          endDate: endDate,
          eventType: eventType,
          isRecurring: isRecurring,
          createdByUserId: createdByUserId,
          createdAt: createdAt,
          updatedAt: updatedAt,
          deletedAt: deletedAt,
        );

  /// Returns a shallow copy of this [SchoolCalendarEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SchoolCalendarEvent copyWith({
    Object? id = _Undefined,
    _i1.UuidValue? organizationId,
    String? title,
    Object? description = _Undefined,
    DateTime? eventDate,
    Object? endDate = _Undefined,
    String? eventType,
    bool? isRecurring,
    _i1.UuidValue? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Object? deletedAt = _Undefined,
  }) {
    return SchoolCalendarEvent(
      id: id is _i1.UuidValue? ? id : this.id,
      organizationId: organizationId ?? this.organizationId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      eventDate: eventDate ?? this.eventDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
      eventType: eventType ?? this.eventType,
      isRecurring: isRecurring ?? this.isRecurring,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt is DateTime? ? deletedAt : this.deletedAt,
    );
  }
}
