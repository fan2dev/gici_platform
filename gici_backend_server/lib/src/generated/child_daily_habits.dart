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
import 'meal_entry.dart' as _i2;
import 'nap_entry.dart' as _i3;
import 'bowel_movement_entry.dart' as _i4;

abstract class ChildDailyHabits
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChildDailyHabits._({
    required this.childId,
    required this.day,
    required this.meals,
    required this.naps,
    required this.bowelMovements,
  });

  factory ChildDailyHabits({
    required _i1.UuidValue childId,
    required DateTime day,
    required List<_i2.MealEntry> meals,
    required List<_i3.NapEntry> naps,
    required List<_i4.BowelMovementEntry> bowelMovements,
  }) = _ChildDailyHabitsImpl;

  factory ChildDailyHabits.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChildDailyHabits(
      childId:
          _i1.UuidValueJsonExtension.fromJson(jsonSerialization['childId']),
      day: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['day']),
      meals: (jsonSerialization['meals'] as List)
          .map((e) => _i2.MealEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
      naps: (jsonSerialization['naps'] as List)
          .map((e) => _i3.NapEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
      bowelMovements: (jsonSerialization['bowelMovements'] as List)
          .map((e) =>
              _i4.BowelMovementEntry.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i1.UuidValue childId;

  DateTime day;

  List<_i2.MealEntry> meals;

  List<_i3.NapEntry> naps;

  List<_i4.BowelMovementEntry> bowelMovements;

  /// Returns a shallow copy of this [ChildDailyHabits]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChildDailyHabits copyWith({
    _i1.UuidValue? childId,
    DateTime? day,
    List<_i2.MealEntry>? meals,
    List<_i3.NapEntry>? naps,
    List<_i4.BowelMovementEntry>? bowelMovements,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'childId': childId.toJson(),
      'day': day.toJson(),
      'meals': meals.toJson(valueToJson: (v) => v.toJson()),
      'naps': naps.toJson(valueToJson: (v) => v.toJson()),
      'bowelMovements': bowelMovements.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'childId': childId.toJson(),
      'day': day.toJson(),
      'meals': meals.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'naps': naps.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'bowelMovements':
          bowelMovements.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _ChildDailyHabitsImpl extends ChildDailyHabits {
  _ChildDailyHabitsImpl({
    required _i1.UuidValue childId,
    required DateTime day,
    required List<_i2.MealEntry> meals,
    required List<_i3.NapEntry> naps,
    required List<_i4.BowelMovementEntry> bowelMovements,
  }) : super._(
          childId: childId,
          day: day,
          meals: meals,
          naps: naps,
          bowelMovements: bowelMovements,
        );

  /// Returns a shallow copy of this [ChildDailyHabits]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChildDailyHabits copyWith({
    _i1.UuidValue? childId,
    DateTime? day,
    List<_i2.MealEntry>? meals,
    List<_i3.NapEntry>? naps,
    List<_i4.BowelMovementEntry>? bowelMovements,
  }) {
    return ChildDailyHabits(
      childId: childId ?? this.childId,
      day: day ?? this.day,
      meals: meals ?? this.meals.map((e0) => e0.copyWith()).toList(),
      naps: naps ?? this.naps.map((e0) => e0.copyWith()).toList(),
      bowelMovements: bowelMovements ??
          this.bowelMovements.map((e0) => e0.copyWith()).toList(),
    );
  }
}
