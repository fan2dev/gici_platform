/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class ChildTimelineItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChildTimelineItem._({
    required this.childId,
    required this.eventAt,
    required this.eventType,
    required this.title,
    this.description,
    this.referenceType,
    this.referenceId,
  });

  factory ChildTimelineItem({
    required _i1.UuidValue childId,
    required DateTime eventAt,
    required String eventType,
    required String title,
    String? description,
    String? referenceType,
    String? referenceId,
  }) = _ChildTimelineItemImpl;

  factory ChildTimelineItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChildTimelineItem(
      childId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      eventAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['eventAt']),
      eventType: jsonSerialization['eventType'] as String,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      referenceType: jsonSerialization['referenceType'] as String?,
      referenceId: jsonSerialization['referenceId'] as String?,
    );
  }

  _i1.UuidValue childId;

  DateTime eventAt;

  String eventType;

  String title;

  String? description;

  String? referenceType;

  String? referenceId;

  /// Returns a shallow copy of this [ChildTimelineItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChildTimelineItem copyWith({
    _i1.UuidValue? childId,
    DateTime? eventAt,
    String? eventType,
    String? title,
    String? description,
    String? referenceType,
    String? referenceId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'childId': childId.toJson(),
      'eventAt': eventAt.toJson(),
      'eventType': eventType,
      'title': title,
      if (description != null) 'description': description,
      if (referenceType != null) 'referenceType': referenceType,
      if (referenceId != null) 'referenceId': referenceId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'childId': childId.toJson(),
      'eventAt': eventAt.toJson(),
      'eventType': eventType,
      'title': title,
      if (description != null) 'description': description,
      if (referenceType != null) 'referenceType': referenceType,
      if (referenceId != null) 'referenceId': referenceId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChildTimelineItemImpl extends ChildTimelineItem {
  _ChildTimelineItemImpl({
    required _i1.UuidValue childId,
    required DateTime eventAt,
    required String eventType,
    required String title,
    String? description,
    String? referenceType,
    String? referenceId,
  }) : super._(
          childId: childId,
          eventAt: eventAt,
          eventType: eventType,
          title: title,
          description: description,
          referenceType: referenceType,
          referenceId: referenceId,
        );

  /// Returns a shallow copy of this [ChildTimelineItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChildTimelineItem copyWith({
    _i1.UuidValue? childId,
    DateTime? eventAt,
    String? eventType,
    String? title,
    Object? description = _Undefined,
    Object? referenceType = _Undefined,
    Object? referenceId = _Undefined,
  }) {
    return ChildTimelineItem(
      childId: childId ?? this.childId,
      eventAt: eventAt ?? this.eventAt,
      eventType: eventType ?? this.eventType,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      referenceType:
          referenceType is String? ? referenceType : this.referenceType,
      referenceId: referenceId is String? ? referenceId : this.referenceId,
    );
  }
}
