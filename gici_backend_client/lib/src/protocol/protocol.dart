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
import 'child_profile_overview.dart' as _i2;
import 'activity_log.dart' as _i3;
import 'app_user.dart' as _i4;
import 'auth_session.dart' as _i5;
import 'bowel_movement_entry.dart' as _i6;
import 'chat_conversation.dart' as _i7;
import 'chat_message.dart' as _i8;
import 'chat_participant.dart' as _i9;
import 'child.dart' as _i10;
import 'child_daily_habits.dart' as _i11;
import 'child_document.dart' as _i12;
import 'child_guardian_relation.dart' as _i13;
import 'absence.dart' as _i14;
import 'child_tariff_assignment.dart' as _i15;
import 'child_timeline_item.dart' as _i16;
import 'classroom.dart' as _i17;
import 'classroom_assignment.dart' as _i18;
import 'consent_record.dart' as _i19;
import 'dashboard_summary.dart' as _i20;
import 'data_change_request.dart' as _i21;
import 'file_asset.dart' as _i22;
import 'gallery.dart' as _i23;
import 'gallery_item.dart' as _i24;
import 'meal_entry.dart' as _i25;
import 'user_onboarding_state.dart' as _i26;
import 'nap_entry.dart' as _i27;
import 'notification_record.dart' as _i28;
import 'organization.dart' as _i29;
import 'organization_branding.dart' as _i30;
import 'organization_document.dart' as _i31;
import 'organization_settings.dart' as _i32;
import 'pedagogical_report.dart' as _i33;
import 'push_device_token.dart' as _i34;
import 'school_calendar_event.dart' as _i35;
import 'staff_classroom_permission.dart' as _i36;
import 'tariff.dart' as _i37;
import 'time_entry.dart' as _i38;
import 'menu_entry.dart' as _i39;
import 'package:gici_backend_client/src/protocol/absence.dart' as _i40;
import 'package:gici_backend_client/src/protocol/school_calendar_event.dart'
    as _i41;
import 'package:gici_backend_client/src/protocol/chat_conversation.dart'
    as _i42;
import 'package:uuid/uuid_value.dart' as _i43;
import 'package:gici_backend_client/src/protocol/chat_message.dart' as _i44;
import 'package:gici_backend_client/src/protocol/child.dart' as _i45;
import 'package:gici_backend_client/src/protocol/child_guardian_relation.dart'
    as _i46;
import 'package:gici_backend_client/src/protocol/child_timeline_item.dart'
    as _i47;
import 'package:gici_backend_client/src/protocol/classroom.dart' as _i48;
import 'package:gici_backend_client/src/protocol/classroom_assignment.dart'
    as _i49;
import 'package:gici_backend_client/src/protocol/consent_record.dart' as _i50;
import 'package:gici_backend_client/src/protocol/data_change_request.dart'
    as _i51;
import 'package:gici_backend_client/src/protocol/organization_document.dart'
    as _i52;
import 'package:gici_backend_client/src/protocol/child_document.dart' as _i53;
import 'package:gici_backend_client/src/protocol/menu_entry.dart' as _i54;
import 'package:gici_backend_client/src/protocol/gallery.dart' as _i55;
import 'package:gici_backend_client/src/protocol/gallery_item.dart' as _i56;
import 'package:gici_backend_client/src/protocol/meal_entry.dart' as _i57;
import 'package:gici_backend_client/src/protocol/nap_entry.dart' as _i58;
import 'package:gici_backend_client/src/protocol/bowel_movement_entry.dart'
    as _i59;
import 'package:gici_backend_client/src/protocol/notification_record.dart'
    as _i60;
import 'package:gici_backend_client/src/protocol/organization.dart' as _i61;
import 'package:gici_backend_client/src/protocol/pedagogical_report.dart'
    as _i62;
import 'package:gici_backend_client/src/protocol/app_user.dart' as _i63;
import 'package:gici_backend_client/src/protocol/staff_classroom_permission.dart'
    as _i64;
import 'package:gici_backend_client/src/protocol/tariff.dart' as _i65;
import 'package:gici_backend_client/src/protocol/child_tariff_assignment.dart'
    as _i66;
import 'package:gici_backend_client/src/protocol/time_entry.dart' as _i67;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i68;
export 'absence.dart';
export 'activity_log.dart';
export 'app_user.dart';
export 'auth_session.dart';
export 'bowel_movement_entry.dart';
export 'chat_conversation.dart';
export 'chat_message.dart';
export 'chat_participant.dart';
export 'child.dart';
export 'child_daily_habits.dart';
export 'child_document.dart';
export 'child_guardian_relation.dart';
export 'child_profile_overview.dart';
export 'child_tariff_assignment.dart';
export 'child_timeline_item.dart';
export 'classroom.dart';
export 'classroom_assignment.dart';
export 'consent_record.dart';
export 'dashboard_summary.dart';
export 'data_change_request.dart';
export 'file_asset.dart';
export 'gallery.dart';
export 'gallery_item.dart';
export 'meal_entry.dart';
export 'menu_entry.dart';
export 'nap_entry.dart';
export 'notification_record.dart';
export 'organization.dart';
export 'organization_branding.dart';
export 'organization_document.dart';
export 'organization_settings.dart';
export 'pedagogical_report.dart';
export 'push_device_token.dart';
export 'school_calendar_event.dart';
export 'staff_classroom_permission.dart';
export 'tariff.dart';
export 'time_entry.dart';
export 'user_onboarding_state.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;
    if (t == _i2.ChildProfileOverview) {
      return _i2.ChildProfileOverview.fromJson(data) as T;
    }
    if (t == _i3.ActivityLog) {
      return _i3.ActivityLog.fromJson(data) as T;
    }
    if (t == _i4.AppUser) {
      return _i4.AppUser.fromJson(data) as T;
    }
    if (t == _i5.AuthSession) {
      return _i5.AuthSession.fromJson(data) as T;
    }
    if (t == _i6.BowelMovementEntry) {
      return _i6.BowelMovementEntry.fromJson(data) as T;
    }
    if (t == _i7.ChatConversation) {
      return _i7.ChatConversation.fromJson(data) as T;
    }
    if (t == _i8.ChatMessage) {
      return _i8.ChatMessage.fromJson(data) as T;
    }
    if (t == _i9.ChatParticipant) {
      return _i9.ChatParticipant.fromJson(data) as T;
    }
    if (t == _i10.Child) {
      return _i10.Child.fromJson(data) as T;
    }
    if (t == _i11.ChildDailyHabits) {
      return _i11.ChildDailyHabits.fromJson(data) as T;
    }
    if (t == _i12.ChildDocument) {
      return _i12.ChildDocument.fromJson(data) as T;
    }
    if (t == _i13.ChildGuardianRelation) {
      return _i13.ChildGuardianRelation.fromJson(data) as T;
    }
    if (t == _i14.Absence) {
      return _i14.Absence.fromJson(data) as T;
    }
    if (t == _i15.ChildTariffAssignment) {
      return _i15.ChildTariffAssignment.fromJson(data) as T;
    }
    if (t == _i16.ChildTimelineItem) {
      return _i16.ChildTimelineItem.fromJson(data) as T;
    }
    if (t == _i17.Classroom) {
      return _i17.Classroom.fromJson(data) as T;
    }
    if (t == _i18.ClassroomAssignment) {
      return _i18.ClassroomAssignment.fromJson(data) as T;
    }
    if (t == _i19.ConsentRecord) {
      return _i19.ConsentRecord.fromJson(data) as T;
    }
    if (t == _i20.DashboardSummary) {
      return _i20.DashboardSummary.fromJson(data) as T;
    }
    if (t == _i21.DataChangeRequest) {
      return _i21.DataChangeRequest.fromJson(data) as T;
    }
    if (t == _i22.FileAsset) {
      return _i22.FileAsset.fromJson(data) as T;
    }
    if (t == _i23.Gallery) {
      return _i23.Gallery.fromJson(data) as T;
    }
    if (t == _i24.GalleryItem) {
      return _i24.GalleryItem.fromJson(data) as T;
    }
    if (t == _i25.MealEntry) {
      return _i25.MealEntry.fromJson(data) as T;
    }
    if (t == _i26.UserOnboardingState) {
      return _i26.UserOnboardingState.fromJson(data) as T;
    }
    if (t == _i27.NapEntry) {
      return _i27.NapEntry.fromJson(data) as T;
    }
    if (t == _i28.NotificationRecord) {
      return _i28.NotificationRecord.fromJson(data) as T;
    }
    if (t == _i29.Organization) {
      return _i29.Organization.fromJson(data) as T;
    }
    if (t == _i30.OrganizationBranding) {
      return _i30.OrganizationBranding.fromJson(data) as T;
    }
    if (t == _i31.OrganizationDocument) {
      return _i31.OrganizationDocument.fromJson(data) as T;
    }
    if (t == _i32.OrganizationSettings) {
      return _i32.OrganizationSettings.fromJson(data) as T;
    }
    if (t == _i33.PedagogicalReport) {
      return _i33.PedagogicalReport.fromJson(data) as T;
    }
    if (t == _i34.PushDeviceToken) {
      return _i34.PushDeviceToken.fromJson(data) as T;
    }
    if (t == _i35.SchoolCalendarEvent) {
      return _i35.SchoolCalendarEvent.fromJson(data) as T;
    }
    if (t == _i36.StaffClassroomPermission) {
      return _i36.StaffClassroomPermission.fromJson(data) as T;
    }
    if (t == _i37.Tariff) {
      return _i37.Tariff.fromJson(data) as T;
    }
    if (t == _i38.TimeEntry) {
      return _i38.TimeEntry.fromJson(data) as T;
    }
    if (t == _i39.MenuEntry) {
      return _i39.MenuEntry.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ChildProfileOverview?>()) {
      return (data != null ? _i2.ChildProfileOverview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i3.ActivityLog?>()) {
      return (data != null ? _i3.ActivityLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AppUser?>()) {
      return (data != null ? _i4.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.AuthSession?>()) {
      return (data != null ? _i5.AuthSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.BowelMovementEntry?>()) {
      return (data != null ? _i6.BowelMovementEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ChatConversation?>()) {
      return (data != null ? _i7.ChatConversation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ChatMessage?>()) {
      return (data != null ? _i8.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ChatParticipant?>()) {
      return (data != null ? _i9.ChatParticipant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.Child?>()) {
      return (data != null ? _i10.Child.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ChildDailyHabits?>()) {
      return (data != null ? _i11.ChildDailyHabits.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ChildDocument?>()) {
      return (data != null ? _i12.ChildDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.ChildGuardianRelation?>()) {
      return (data != null ? _i13.ChildGuardianRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.Absence?>()) {
      return (data != null ? _i14.Absence.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.ChildTariffAssignment?>()) {
      return (data != null ? _i15.ChildTariffAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.ChildTimelineItem?>()) {
      return (data != null ? _i16.ChildTimelineItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Classroom?>()) {
      return (data != null ? _i17.Classroom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ClassroomAssignment?>()) {
      return (data != null ? _i18.ClassroomAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i19.ConsentRecord?>()) {
      return (data != null ? _i19.ConsentRecord.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.DashboardSummary?>()) {
      return (data != null ? _i20.DashboardSummary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.DataChangeRequest?>()) {
      return (data != null ? _i21.DataChangeRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.FileAsset?>()) {
      return (data != null ? _i22.FileAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.Gallery?>()) {
      return (data != null ? _i23.Gallery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.GalleryItem?>()) {
      return (data != null ? _i24.GalleryItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.MealEntry?>()) {
      return (data != null ? _i25.MealEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.UserOnboardingState?>()) {
      return (data != null ? _i26.UserOnboardingState.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.NapEntry?>()) {
      return (data != null ? _i27.NapEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.NotificationRecord?>()) {
      return (data != null ? _i28.NotificationRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.Organization?>()) {
      return (data != null ? _i29.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.OrganizationBranding?>()) {
      return (data != null ? _i30.OrganizationBranding.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.OrganizationDocument?>()) {
      return (data != null ? _i31.OrganizationDocument.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i32.OrganizationSettings?>()) {
      return (data != null ? _i32.OrganizationSettings.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i33.PedagogicalReport?>()) {
      return (data != null ? _i33.PedagogicalReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.PushDeviceToken?>()) {
      return (data != null ? _i34.PushDeviceToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.SchoolCalendarEvent?>()) {
      return (data != null ? _i35.SchoolCalendarEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i36.StaffClassroomPermission?>()) {
      return (data != null
          ? _i36.StaffClassroomPermission.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i37.Tariff?>()) {
      return (data != null ? _i37.Tariff.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.TimeEntry?>()) {
      return (data != null ? _i38.TimeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.MenuEntry?>()) {
      return (data != null ? _i39.MenuEntry.fromJson(data) : null) as T;
    }
    if (t == List<_i1.UuidValue>) {
      return (data as List).map((e) => deserialize<_i1.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i25.MealEntry>) {
      return (data as List).map((e) => deserialize<_i25.MealEntry>(e)).toList()
          as T;
    }
    if (t == List<_i27.NapEntry>) {
      return (data as List).map((e) => deserialize<_i27.NapEntry>(e)).toList()
          as T;
    }
    if (t == List<_i6.BowelMovementEntry>) {
      return (data as List)
          .map((e) => deserialize<_i6.BowelMovementEntry>(e))
          .toList() as T;
    }
    if (t == List<_i39.MenuEntry>) {
      return (data as List).map((e) => deserialize<_i39.MenuEntry>(e)).toList()
          as T;
    }
    if (t == List<_i35.SchoolCalendarEvent>) {
      return (data as List)
          .map((e) => deserialize<_i35.SchoolCalendarEvent>(e))
          .toList() as T;
    }
    if (t == List<_i28.NotificationRecord>) {
      return (data as List)
          .map((e) => deserialize<_i28.NotificationRecord>(e))
          .toList() as T;
    }
    if (t == List<_i40.Absence>) {
      return (data as List).map((e) => deserialize<_i40.Absence>(e)).toList()
          as T;
    }
    if (t == List<_i41.SchoolCalendarEvent>) {
      return (data as List)
          .map((e) => deserialize<_i41.SchoolCalendarEvent>(e))
          .toList() as T;
    }
    if (t == List<_i42.ChatConversation>) {
      return (data as List)
          .map((e) => deserialize<_i42.ChatConversation>(e))
          .toList() as T;
    }
    if (t == List<_i43.UuidValue>) {
      return (data as List).map((e) => deserialize<_i43.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_i44.ChatMessage>) {
      return (data as List)
          .map((e) => deserialize<_i44.ChatMessage>(e))
          .toList() as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    if (t == List<_i45.Child>) {
      return (data as List).map((e) => deserialize<_i45.Child>(e)).toList()
          as T;
    }
    if (t == List<_i46.ChildGuardianRelation>) {
      return (data as List)
          .map((e) => deserialize<_i46.ChildGuardianRelation>(e))
          .toList() as T;
    }
    if (t == List<_i47.ChildTimelineItem>) {
      return (data as List)
          .map((e) => deserialize<_i47.ChildTimelineItem>(e))
          .toList() as T;
    }
    if (t == List<_i48.Classroom>) {
      return (data as List).map((e) => deserialize<_i48.Classroom>(e)).toList()
          as T;
    }
    if (t == List<_i49.ClassroomAssignment>) {
      return (data as List)
          .map((e) => deserialize<_i49.ClassroomAssignment>(e))
          .toList() as T;
    }
    if (t == List<_i50.ConsentRecord>) {
      return (data as List)
          .map((e) => deserialize<_i50.ConsentRecord>(e))
          .toList() as T;
    }
    if (t == List<_i51.DataChangeRequest>) {
      return (data as List)
          .map((e) => deserialize<_i51.DataChangeRequest>(e))
          .toList() as T;
    }
    if (t == List<_i52.OrganizationDocument>) {
      return (data as List)
          .map((e) => deserialize<_i52.OrganizationDocument>(e))
          .toList() as T;
    }
    if (t == List<_i53.ChildDocument>) {
      return (data as List)
          .map((e) => deserialize<_i53.ChildDocument>(e))
          .toList() as T;
    }
    if (t == List<_i54.MenuEntry>) {
      return (data as List).map((e) => deserialize<_i54.MenuEntry>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i55.Gallery>) {
      return (data as List).map((e) => deserialize<_i55.Gallery>(e)).toList()
          as T;
    }
    if (t == List<_i56.GalleryItem>) {
      return (data as List)
          .map((e) => deserialize<_i56.GalleryItem>(e))
          .toList() as T;
    }
    if (t == List<_i57.MealEntry>) {
      return (data as List).map((e) => deserialize<_i57.MealEntry>(e)).toList()
          as T;
    }
    if (t == List<_i58.NapEntry>) {
      return (data as List).map((e) => deserialize<_i58.NapEntry>(e)).toList()
          as T;
    }
    if (t == List<_i59.BowelMovementEntry>) {
      return (data as List)
          .map((e) => deserialize<_i59.BowelMovementEntry>(e))
          .toList() as T;
    }
    if (t == List<_i60.NotificationRecord>) {
      return (data as List)
          .map((e) => deserialize<_i60.NotificationRecord>(e))
          .toList() as T;
    }
    if (t == List<_i61.Organization>) {
      return (data as List)
          .map((e) => deserialize<_i61.Organization>(e))
          .toList() as T;
    }
    if (t == List<_i62.PedagogicalReport>) {
      return (data as List)
          .map((e) => deserialize<_i62.PedagogicalReport>(e))
          .toList() as T;
    }
    if (t == List<_i63.AppUser>) {
      return (data as List).map((e) => deserialize<_i63.AppUser>(e)).toList()
          as T;
    }
    if (t == List<_i64.StaffClassroomPermission>) {
      return (data as List)
          .map((e) => deserialize<_i64.StaffClassroomPermission>(e))
          .toList() as T;
    }
    if (t == List<_i65.Tariff>) {
      return (data as List).map((e) => deserialize<_i65.Tariff>(e)).toList()
          as T;
    }
    if (t == List<_i66.ChildTariffAssignment>) {
      return (data as List)
          .map((e) => deserialize<_i66.ChildTariffAssignment>(e))
          .toList() as T;
    }
    if (t == List<_i67.TimeEntry>) {
      return (data as List).map((e) => deserialize<_i67.TimeEntry>(e)).toList()
          as T;
    }
    try {
      return _i68.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.ChildProfileOverview) {
      return 'ChildProfileOverview';
    }
    if (data is _i3.ActivityLog) {
      return 'ActivityLog';
    }
    if (data is _i4.AppUser) {
      return 'AppUser';
    }
    if (data is _i5.AuthSession) {
      return 'AuthSession';
    }
    if (data is _i6.BowelMovementEntry) {
      return 'BowelMovementEntry';
    }
    if (data is _i7.ChatConversation) {
      return 'ChatConversation';
    }
    if (data is _i8.ChatMessage) {
      return 'ChatMessage';
    }
    if (data is _i9.ChatParticipant) {
      return 'ChatParticipant';
    }
    if (data is _i10.Child) {
      return 'Child';
    }
    if (data is _i11.ChildDailyHabits) {
      return 'ChildDailyHabits';
    }
    if (data is _i12.ChildDocument) {
      return 'ChildDocument';
    }
    if (data is _i13.ChildGuardianRelation) {
      return 'ChildGuardianRelation';
    }
    if (data is _i14.Absence) {
      return 'Absence';
    }
    if (data is _i15.ChildTariffAssignment) {
      return 'ChildTariffAssignment';
    }
    if (data is _i16.ChildTimelineItem) {
      return 'ChildTimelineItem';
    }
    if (data is _i17.Classroom) {
      return 'Classroom';
    }
    if (data is _i18.ClassroomAssignment) {
      return 'ClassroomAssignment';
    }
    if (data is _i19.ConsentRecord) {
      return 'ConsentRecord';
    }
    if (data is _i20.DashboardSummary) {
      return 'DashboardSummary';
    }
    if (data is _i21.DataChangeRequest) {
      return 'DataChangeRequest';
    }
    if (data is _i22.FileAsset) {
      return 'FileAsset';
    }
    if (data is _i23.Gallery) {
      return 'Gallery';
    }
    if (data is _i24.GalleryItem) {
      return 'GalleryItem';
    }
    if (data is _i25.MealEntry) {
      return 'MealEntry';
    }
    if (data is _i26.UserOnboardingState) {
      return 'UserOnboardingState';
    }
    if (data is _i27.NapEntry) {
      return 'NapEntry';
    }
    if (data is _i28.NotificationRecord) {
      return 'NotificationRecord';
    }
    if (data is _i29.Organization) {
      return 'Organization';
    }
    if (data is _i30.OrganizationBranding) {
      return 'OrganizationBranding';
    }
    if (data is _i31.OrganizationDocument) {
      return 'OrganizationDocument';
    }
    if (data is _i32.OrganizationSettings) {
      return 'OrganizationSettings';
    }
    if (data is _i33.PedagogicalReport) {
      return 'PedagogicalReport';
    }
    if (data is _i34.PushDeviceToken) {
      return 'PushDeviceToken';
    }
    if (data is _i35.SchoolCalendarEvent) {
      return 'SchoolCalendarEvent';
    }
    if (data is _i36.StaffClassroomPermission) {
      return 'StaffClassroomPermission';
    }
    if (data is _i37.Tariff) {
      return 'Tariff';
    }
    if (data is _i38.TimeEntry) {
      return 'TimeEntry';
    }
    if (data is _i39.MenuEntry) {
      return 'MenuEntry';
    }
    className = _i68.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'ChildProfileOverview') {
      return deserialize<_i2.ChildProfileOverview>(data['data']);
    }
    if (dataClassName == 'ActivityLog') {
      return deserialize<_i3.ActivityLog>(data['data']);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i4.AppUser>(data['data']);
    }
    if (dataClassName == 'AuthSession') {
      return deserialize<_i5.AuthSession>(data['data']);
    }
    if (dataClassName == 'BowelMovementEntry') {
      return deserialize<_i6.BowelMovementEntry>(data['data']);
    }
    if (dataClassName == 'ChatConversation') {
      return deserialize<_i7.ChatConversation>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i8.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatParticipant') {
      return deserialize<_i9.ChatParticipant>(data['data']);
    }
    if (dataClassName == 'Child') {
      return deserialize<_i10.Child>(data['data']);
    }
    if (dataClassName == 'ChildDailyHabits') {
      return deserialize<_i11.ChildDailyHabits>(data['data']);
    }
    if (dataClassName == 'ChildDocument') {
      return deserialize<_i12.ChildDocument>(data['data']);
    }
    if (dataClassName == 'ChildGuardianRelation') {
      return deserialize<_i13.ChildGuardianRelation>(data['data']);
    }
    if (dataClassName == 'Absence') {
      return deserialize<_i14.Absence>(data['data']);
    }
    if (dataClassName == 'ChildTariffAssignment') {
      return deserialize<_i15.ChildTariffAssignment>(data['data']);
    }
    if (dataClassName == 'ChildTimelineItem') {
      return deserialize<_i16.ChildTimelineItem>(data['data']);
    }
    if (dataClassName == 'Classroom') {
      return deserialize<_i17.Classroom>(data['data']);
    }
    if (dataClassName == 'ClassroomAssignment') {
      return deserialize<_i18.ClassroomAssignment>(data['data']);
    }
    if (dataClassName == 'ConsentRecord') {
      return deserialize<_i19.ConsentRecord>(data['data']);
    }
    if (dataClassName == 'DashboardSummary') {
      return deserialize<_i20.DashboardSummary>(data['data']);
    }
    if (dataClassName == 'DataChangeRequest') {
      return deserialize<_i21.DataChangeRequest>(data['data']);
    }
    if (dataClassName == 'FileAsset') {
      return deserialize<_i22.FileAsset>(data['data']);
    }
    if (dataClassName == 'Gallery') {
      return deserialize<_i23.Gallery>(data['data']);
    }
    if (dataClassName == 'GalleryItem') {
      return deserialize<_i24.GalleryItem>(data['data']);
    }
    if (dataClassName == 'MealEntry') {
      return deserialize<_i25.MealEntry>(data['data']);
    }
    if (dataClassName == 'UserOnboardingState') {
      return deserialize<_i26.UserOnboardingState>(data['data']);
    }
    if (dataClassName == 'NapEntry') {
      return deserialize<_i27.NapEntry>(data['data']);
    }
    if (dataClassName == 'NotificationRecord') {
      return deserialize<_i28.NotificationRecord>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i29.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationBranding') {
      return deserialize<_i30.OrganizationBranding>(data['data']);
    }
    if (dataClassName == 'OrganizationDocument') {
      return deserialize<_i31.OrganizationDocument>(data['data']);
    }
    if (dataClassName == 'OrganizationSettings') {
      return deserialize<_i32.OrganizationSettings>(data['data']);
    }
    if (dataClassName == 'PedagogicalReport') {
      return deserialize<_i33.PedagogicalReport>(data['data']);
    }
    if (dataClassName == 'PushDeviceToken') {
      return deserialize<_i34.PushDeviceToken>(data['data']);
    }
    if (dataClassName == 'SchoolCalendarEvent') {
      return deserialize<_i35.SchoolCalendarEvent>(data['data']);
    }
    if (dataClassName == 'StaffClassroomPermission') {
      return deserialize<_i36.StaffClassroomPermission>(data['data']);
    }
    if (dataClassName == 'Tariff') {
      return deserialize<_i37.Tariff>(data['data']);
    }
    if (dataClassName == 'TimeEntry') {
      return deserialize<_i38.TimeEntry>(data['data']);
    }
    if (dataClassName == 'MenuEntry') {
      return deserialize<_i39.MenuEntry>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i68.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
