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
import 'activity_log.dart' as _i2;
import 'app_user.dart' as _i3;
import 'auth_session.dart' as _i4;
import 'bowel_movement_entry.dart' as _i5;
import 'chat_conversation.dart' as _i6;
import 'chat_message.dart' as _i7;
import 'chat_participant.dart' as _i8;
import 'child.dart' as _i9;
import 'child_daily_habits.dart' as _i10;
import 'child_document.dart' as _i11;
import 'child_guardian_relation.dart' as _i12;
import 'child_profile_overview.dart' as _i13;
import 'child_timeline_item.dart' as _i14;
import 'classroom.dart' as _i15;
import 'classroom_assignment.dart' as _i16;
import 'data_change_request.dart' as _i17;
import 'file_asset.dart' as _i18;
import 'gallery.dart' as _i19;
import 'gallery_item.dart' as _i20;
import 'meal_entry.dart' as _i21;
import 'menu_entry.dart' as _i22;
import 'nap_entry.dart' as _i23;
import 'notification_record.dart' as _i24;
import 'organization.dart' as _i25;
import 'organization_branding.dart' as _i26;
import 'organization_document.dart' as _i27;
import 'organization_settings.dart' as _i28;
import 'pedagogical_report.dart' as _i29;
import 'push_device_token.dart' as _i30;
import 'time_entry.dart' as _i31;
import 'user_onboarding_state.dart' as _i32;
import 'package:gici_backend_client/src/protocol/chat_conversation.dart'
    as _i33;
import 'package:uuid/uuid_value.dart' as _i34;
import 'package:gici_backend_client/src/protocol/chat_message.dart' as _i35;
import 'package:gici_backend_client/src/protocol/child.dart' as _i36;
import 'package:gici_backend_client/src/protocol/child_timeline_item.dart'
    as _i37;
import 'package:gici_backend_client/src/protocol/classroom.dart' as _i38;
import 'package:gici_backend_client/src/protocol/classroom_assignment.dart'
    as _i39;
import 'package:gici_backend_client/src/protocol/data_change_request.dart'
    as _i40;
import 'package:gici_backend_client/src/protocol/organization_document.dart'
    as _i41;
import 'package:gici_backend_client/src/protocol/child_document.dart' as _i42;
import 'package:gici_backend_client/src/protocol/menu_entry.dart' as _i43;
import 'package:gici_backend_client/src/protocol/gallery.dart' as _i44;
import 'package:gici_backend_client/src/protocol/gallery_item.dart' as _i45;
import 'package:gici_backend_client/src/protocol/meal_entry.dart' as _i46;
import 'package:gici_backend_client/src/protocol/nap_entry.dart' as _i47;
import 'package:gici_backend_client/src/protocol/bowel_movement_entry.dart'
    as _i48;
import 'package:gici_backend_client/src/protocol/notification_record.dart'
    as _i49;
import 'package:gici_backend_client/src/protocol/organization.dart' as _i50;
import 'package:gici_backend_client/src/protocol/pedagogical_report.dart'
    as _i51;
import 'package:gici_backend_client/src/protocol/time_entry.dart' as _i52;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i53;
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
export 'child_timeline_item.dart';
export 'classroom.dart';
export 'classroom_assignment.dart';
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
    if (t == _i2.ActivityLog) {
      return _i2.ActivityLog.fromJson(data) as T;
    }
    if (t == _i3.AppUser) {
      return _i3.AppUser.fromJson(data) as T;
    }
    if (t == _i4.AuthSession) {
      return _i4.AuthSession.fromJson(data) as T;
    }
    if (t == _i5.BowelMovementEntry) {
      return _i5.BowelMovementEntry.fromJson(data) as T;
    }
    if (t == _i6.ChatConversation) {
      return _i6.ChatConversation.fromJson(data) as T;
    }
    if (t == _i7.ChatMessage) {
      return _i7.ChatMessage.fromJson(data) as T;
    }
    if (t == _i8.ChatParticipant) {
      return _i8.ChatParticipant.fromJson(data) as T;
    }
    if (t == _i9.Child) {
      return _i9.Child.fromJson(data) as T;
    }
    if (t == _i10.ChildDailyHabits) {
      return _i10.ChildDailyHabits.fromJson(data) as T;
    }
    if (t == _i11.ChildDocument) {
      return _i11.ChildDocument.fromJson(data) as T;
    }
    if (t == _i12.ChildGuardianRelation) {
      return _i12.ChildGuardianRelation.fromJson(data) as T;
    }
    if (t == _i13.ChildProfileOverview) {
      return _i13.ChildProfileOverview.fromJson(data) as T;
    }
    if (t == _i14.ChildTimelineItem) {
      return _i14.ChildTimelineItem.fromJson(data) as T;
    }
    if (t == _i15.Classroom) {
      return _i15.Classroom.fromJson(data) as T;
    }
    if (t == _i16.ClassroomAssignment) {
      return _i16.ClassroomAssignment.fromJson(data) as T;
    }
    if (t == _i17.DataChangeRequest) {
      return _i17.DataChangeRequest.fromJson(data) as T;
    }
    if (t == _i18.FileAsset) {
      return _i18.FileAsset.fromJson(data) as T;
    }
    if (t == _i19.Gallery) {
      return _i19.Gallery.fromJson(data) as T;
    }
    if (t == _i20.GalleryItem) {
      return _i20.GalleryItem.fromJson(data) as T;
    }
    if (t == _i21.MealEntry) {
      return _i21.MealEntry.fromJson(data) as T;
    }
    if (t == _i22.MenuEntry) {
      return _i22.MenuEntry.fromJson(data) as T;
    }
    if (t == _i23.NapEntry) {
      return _i23.NapEntry.fromJson(data) as T;
    }
    if (t == _i24.NotificationRecord) {
      return _i24.NotificationRecord.fromJson(data) as T;
    }
    if (t == _i25.Organization) {
      return _i25.Organization.fromJson(data) as T;
    }
    if (t == _i26.OrganizationBranding) {
      return _i26.OrganizationBranding.fromJson(data) as T;
    }
    if (t == _i27.OrganizationDocument) {
      return _i27.OrganizationDocument.fromJson(data) as T;
    }
    if (t == _i28.OrganizationSettings) {
      return _i28.OrganizationSettings.fromJson(data) as T;
    }
    if (t == _i29.PedagogicalReport) {
      return _i29.PedagogicalReport.fromJson(data) as T;
    }
    if (t == _i30.PushDeviceToken) {
      return _i30.PushDeviceToken.fromJson(data) as T;
    }
    if (t == _i31.TimeEntry) {
      return _i31.TimeEntry.fromJson(data) as T;
    }
    if (t == _i32.UserOnboardingState) {
      return _i32.UserOnboardingState.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.ActivityLog?>()) {
      return (data != null ? _i2.ActivityLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AppUser?>()) {
      return (data != null ? _i3.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.AuthSession?>()) {
      return (data != null ? _i4.AuthSession.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.BowelMovementEntry?>()) {
      return (data != null ? _i5.BowelMovementEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ChatConversation?>()) {
      return (data != null ? _i6.ChatConversation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ChatMessage?>()) {
      return (data != null ? _i7.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ChatParticipant?>()) {
      return (data != null ? _i8.ChatParticipant.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.Child?>()) {
      return (data != null ? _i9.Child.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ChildDailyHabits?>()) {
      return (data != null ? _i10.ChildDailyHabits.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ChildDocument?>()) {
      return (data != null ? _i11.ChildDocument.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ChildGuardianRelation?>()) {
      return (data != null ? _i12.ChildGuardianRelation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.ChildProfileOverview?>()) {
      return (data != null ? _i13.ChildProfileOverview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.ChildTimelineItem?>()) {
      return (data != null ? _i14.ChildTimelineItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Classroom?>()) {
      return (data != null ? _i15.Classroom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.ClassroomAssignment?>()) {
      return (data != null ? _i16.ClassroomAssignment.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i17.DataChangeRequest?>()) {
      return (data != null ? _i17.DataChangeRequest.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.FileAsset?>()) {
      return (data != null ? _i18.FileAsset.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Gallery?>()) {
      return (data != null ? _i19.Gallery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.GalleryItem?>()) {
      return (data != null ? _i20.GalleryItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.MealEntry?>()) {
      return (data != null ? _i21.MealEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.MenuEntry?>()) {
      return (data != null ? _i22.MenuEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.NapEntry?>()) {
      return (data != null ? _i23.NapEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.NotificationRecord?>()) {
      return (data != null ? _i24.NotificationRecord.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i25.Organization?>()) {
      return (data != null ? _i25.Organization.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i26.OrganizationBranding?>()) {
      return (data != null ? _i26.OrganizationBranding.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i27.OrganizationDocument?>()) {
      return (data != null ? _i27.OrganizationDocument.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i28.OrganizationSettings?>()) {
      return (data != null ? _i28.OrganizationSettings.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i29.PedagogicalReport?>()) {
      return (data != null ? _i29.PedagogicalReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.PushDeviceToken?>()) {
      return (data != null ? _i30.PushDeviceToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i31.TimeEntry?>()) {
      return (data != null ? _i31.TimeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.UserOnboardingState?>()) {
      return (data != null ? _i32.UserOnboardingState.fromJson(data) : null)
          as T;
    }
    if (t == List<_i21.MealEntry>) {
      return (data as List).map((e) => deserialize<_i21.MealEntry>(e)).toList()
          as T;
    }
    if (t == List<_i23.NapEntry>) {
      return (data as List).map((e) => deserialize<_i23.NapEntry>(e)).toList()
          as T;
    }
    if (t == List<_i5.BowelMovementEntry>) {
      return (data as List)
          .map((e) => deserialize<_i5.BowelMovementEntry>(e))
          .toList() as T;
    }
    if (t == List<_i1.UuidValue>) {
      return (data as List).map((e) => deserialize<_i1.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i33.ChatConversation>) {
      return (data as List)
          .map((e) => deserialize<_i33.ChatConversation>(e))
          .toList() as T;
    }
    if (t == List<_i34.UuidValue>) {
      return (data as List).map((e) => deserialize<_i34.UuidValue>(e)).toList()
          as T;
    }
    if (t == List<_i35.ChatMessage>) {
      return (data as List)
          .map((e) => deserialize<_i35.ChatMessage>(e))
          .toList() as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
          (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v))) as T;
    }
    if (t == List<_i36.Child>) {
      return (data as List).map((e) => deserialize<_i36.Child>(e)).toList()
          as T;
    }
    if (t == List<_i37.ChildTimelineItem>) {
      return (data as List)
          .map((e) => deserialize<_i37.ChildTimelineItem>(e))
          .toList() as T;
    }
    if (t == List<_i38.Classroom>) {
      return (data as List).map((e) => deserialize<_i38.Classroom>(e)).toList()
          as T;
    }
    if (t == List<_i39.ClassroomAssignment>) {
      return (data as List)
          .map((e) => deserialize<_i39.ClassroomAssignment>(e))
          .toList() as T;
    }
    if (t == List<_i40.DataChangeRequest>) {
      return (data as List)
          .map((e) => deserialize<_i40.DataChangeRequest>(e))
          .toList() as T;
    }
    if (t == List<_i41.OrganizationDocument>) {
      return (data as List)
          .map((e) => deserialize<_i41.OrganizationDocument>(e))
          .toList() as T;
    }
    if (t == List<_i42.ChildDocument>) {
      return (data as List)
          .map((e) => deserialize<_i42.ChildDocument>(e))
          .toList() as T;
    }
    if (t == List<_i43.MenuEntry>) {
      return (data as List).map((e) => deserialize<_i43.MenuEntry>(e)).toList()
          as T;
    }
    if (t == List<_i44.Gallery>) {
      return (data as List).map((e) => deserialize<_i44.Gallery>(e)).toList()
          as T;
    }
    if (t == List<_i45.GalleryItem>) {
      return (data as List)
          .map((e) => deserialize<_i45.GalleryItem>(e))
          .toList() as T;
    }
    if (t == List<_i46.MealEntry>) {
      return (data as List).map((e) => deserialize<_i46.MealEntry>(e)).toList()
          as T;
    }
    if (t == List<_i47.NapEntry>) {
      return (data as List).map((e) => deserialize<_i47.NapEntry>(e)).toList()
          as T;
    }
    if (t == List<_i48.BowelMovementEntry>) {
      return (data as List)
          .map((e) => deserialize<_i48.BowelMovementEntry>(e))
          .toList() as T;
    }
    if (t == List<_i49.NotificationRecord>) {
      return (data as List)
          .map((e) => deserialize<_i49.NotificationRecord>(e))
          .toList() as T;
    }
    if (t == List<_i50.Organization>) {
      return (data as List)
          .map((e) => deserialize<_i50.Organization>(e))
          .toList() as T;
    }
    if (t == List<_i51.PedagogicalReport>) {
      return (data as List)
          .map((e) => deserialize<_i51.PedagogicalReport>(e))
          .toList() as T;
    }
    if (t == List<_i52.TimeEntry>) {
      return (data as List).map((e) => deserialize<_i52.TimeEntry>(e)).toList()
          as T;
    }
    try {
      return _i53.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;
    if (data is _i2.ActivityLog) {
      return 'ActivityLog';
    }
    if (data is _i3.AppUser) {
      return 'AppUser';
    }
    if (data is _i4.AuthSession) {
      return 'AuthSession';
    }
    if (data is _i5.BowelMovementEntry) {
      return 'BowelMovementEntry';
    }
    if (data is _i6.ChatConversation) {
      return 'ChatConversation';
    }
    if (data is _i7.ChatMessage) {
      return 'ChatMessage';
    }
    if (data is _i8.ChatParticipant) {
      return 'ChatParticipant';
    }
    if (data is _i9.Child) {
      return 'Child';
    }
    if (data is _i10.ChildDailyHabits) {
      return 'ChildDailyHabits';
    }
    if (data is _i11.ChildDocument) {
      return 'ChildDocument';
    }
    if (data is _i12.ChildGuardianRelation) {
      return 'ChildGuardianRelation';
    }
    if (data is _i13.ChildProfileOverview) {
      return 'ChildProfileOverview';
    }
    if (data is _i14.ChildTimelineItem) {
      return 'ChildTimelineItem';
    }
    if (data is _i15.Classroom) {
      return 'Classroom';
    }
    if (data is _i16.ClassroomAssignment) {
      return 'ClassroomAssignment';
    }
    if (data is _i17.DataChangeRequest) {
      return 'DataChangeRequest';
    }
    if (data is _i18.FileAsset) {
      return 'FileAsset';
    }
    if (data is _i19.Gallery) {
      return 'Gallery';
    }
    if (data is _i20.GalleryItem) {
      return 'GalleryItem';
    }
    if (data is _i21.MealEntry) {
      return 'MealEntry';
    }
    if (data is _i22.MenuEntry) {
      return 'MenuEntry';
    }
    if (data is _i23.NapEntry) {
      return 'NapEntry';
    }
    if (data is _i24.NotificationRecord) {
      return 'NotificationRecord';
    }
    if (data is _i25.Organization) {
      return 'Organization';
    }
    if (data is _i26.OrganizationBranding) {
      return 'OrganizationBranding';
    }
    if (data is _i27.OrganizationDocument) {
      return 'OrganizationDocument';
    }
    if (data is _i28.OrganizationSettings) {
      return 'OrganizationSettings';
    }
    if (data is _i29.PedagogicalReport) {
      return 'PedagogicalReport';
    }
    if (data is _i30.PushDeviceToken) {
      return 'PushDeviceToken';
    }
    if (data is _i31.TimeEntry) {
      return 'TimeEntry';
    }
    if (data is _i32.UserOnboardingState) {
      return 'UserOnboardingState';
    }
    className = _i53.Protocol().getClassNameForObject(data);
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
    if (dataClassName == 'ActivityLog') {
      return deserialize<_i2.ActivityLog>(data['data']);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i3.AppUser>(data['data']);
    }
    if (dataClassName == 'AuthSession') {
      return deserialize<_i4.AuthSession>(data['data']);
    }
    if (dataClassName == 'BowelMovementEntry') {
      return deserialize<_i5.BowelMovementEntry>(data['data']);
    }
    if (dataClassName == 'ChatConversation') {
      return deserialize<_i6.ChatConversation>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i7.ChatMessage>(data['data']);
    }
    if (dataClassName == 'ChatParticipant') {
      return deserialize<_i8.ChatParticipant>(data['data']);
    }
    if (dataClassName == 'Child') {
      return deserialize<_i9.Child>(data['data']);
    }
    if (dataClassName == 'ChildDailyHabits') {
      return deserialize<_i10.ChildDailyHabits>(data['data']);
    }
    if (dataClassName == 'ChildDocument') {
      return deserialize<_i11.ChildDocument>(data['data']);
    }
    if (dataClassName == 'ChildGuardianRelation') {
      return deserialize<_i12.ChildGuardianRelation>(data['data']);
    }
    if (dataClassName == 'ChildProfileOverview') {
      return deserialize<_i13.ChildProfileOverview>(data['data']);
    }
    if (dataClassName == 'ChildTimelineItem') {
      return deserialize<_i14.ChildTimelineItem>(data['data']);
    }
    if (dataClassName == 'Classroom') {
      return deserialize<_i15.Classroom>(data['data']);
    }
    if (dataClassName == 'ClassroomAssignment') {
      return deserialize<_i16.ClassroomAssignment>(data['data']);
    }
    if (dataClassName == 'DataChangeRequest') {
      return deserialize<_i17.DataChangeRequest>(data['data']);
    }
    if (dataClassName == 'FileAsset') {
      return deserialize<_i18.FileAsset>(data['data']);
    }
    if (dataClassName == 'Gallery') {
      return deserialize<_i19.Gallery>(data['data']);
    }
    if (dataClassName == 'GalleryItem') {
      return deserialize<_i20.GalleryItem>(data['data']);
    }
    if (dataClassName == 'MealEntry') {
      return deserialize<_i21.MealEntry>(data['data']);
    }
    if (dataClassName == 'MenuEntry') {
      return deserialize<_i22.MenuEntry>(data['data']);
    }
    if (dataClassName == 'NapEntry') {
      return deserialize<_i23.NapEntry>(data['data']);
    }
    if (dataClassName == 'NotificationRecord') {
      return deserialize<_i24.NotificationRecord>(data['data']);
    }
    if (dataClassName == 'Organization') {
      return deserialize<_i25.Organization>(data['data']);
    }
    if (dataClassName == 'OrganizationBranding') {
      return deserialize<_i26.OrganizationBranding>(data['data']);
    }
    if (dataClassName == 'OrganizationDocument') {
      return deserialize<_i27.OrganizationDocument>(data['data']);
    }
    if (dataClassName == 'OrganizationSettings') {
      return deserialize<_i28.OrganizationSettings>(data['data']);
    }
    if (dataClassName == 'PedagogicalReport') {
      return deserialize<_i29.PedagogicalReport>(data['data']);
    }
    if (dataClassName == 'PushDeviceToken') {
      return deserialize<_i30.PushDeviceToken>(data['data']);
    }
    if (dataClassName == 'TimeEntry') {
      return deserialize<_i31.TimeEntry>(data['data']);
    }
    if (dataClassName == 'UserOnboardingState') {
      return deserialize<_i32.UserOnboardingState>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i53.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }
}
