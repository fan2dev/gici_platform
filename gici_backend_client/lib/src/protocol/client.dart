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
import 'dart:async' as _i2;
import 'package:gici_backend_client/src/protocol/auth_session.dart' as _i3;
import 'package:gici_backend_client/src/protocol/chat_conversation.dart' as _i4;
import 'package:gici_backend_client/src/protocol/chat_message.dart' as _i5;
import 'package:gici_backend_client/src/protocol/child.dart' as _i6;
import 'package:gici_backend_client/src/protocol/child_profile_overview.dart'
    as _i7;
import 'package:gici_backend_client/src/protocol/child_timeline_item.dart'
    as _i8;
import 'package:gici_backend_client/src/protocol/classroom.dart' as _i9;
import 'package:gici_backend_client/src/protocol/classroom_assignment.dart'
    as _i10;
import 'package:gici_backend_client/src/protocol/data_change_request.dart'
    as _i11;
import 'package:gici_backend_client/src/protocol/organization_document.dart'
    as _i12;
import 'package:gici_backend_client/src/protocol/child_document.dart' as _i13;
import 'package:gici_backend_client/src/protocol/user_onboarding_state.dart'
    as _i14;
import 'package:gici_backend_client/src/protocol/organization.dart' as _i15;
import 'package:gici_backend_client/src/protocol/menu_entry.dart' as _i16;
import 'package:gici_backend_client/src/protocol/gallery.dart' as _i17;
import 'package:gici_backend_client/src/protocol/gallery_item.dart' as _i18;
import 'package:gici_backend_client/src/protocol/meal_entry.dart' as _i19;
import 'package:gici_backend_client/src/protocol/nap_entry.dart' as _i20;
import 'package:gici_backend_client/src/protocol/bowel_movement_entry.dart'
    as _i21;
import 'package:gici_backend_client/src/protocol/child_daily_habits.dart'
    as _i22;
import 'package:gici_backend_client/src/protocol/push_device_token.dart'
    as _i23;
import 'package:gici_backend_client/src/protocol/notification_record.dart'
    as _i24;
import 'package:gici_backend_client/src/protocol/pedagogical_report.dart'
    as _i25;
import 'package:gici_backend_client/src/protocol/time_entry.dart' as _i26;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i27;
import 'protocol.dart' as _i28;

/// {@category Endpoint}
class EndpointAuth extends _i1.EndpointRef {
  EndpointAuth(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  _i2.Future<_i3.AuthSession> signInWithEmailPassword({
    required String email,
    required String password,
  }) =>
      caller.callServerEndpoint<_i3.AuthSession>(
        'auth',
        'signInWithEmailPassword',
        {
          'email': email,
          'password': password,
        },
      );

  _i2.Future<_i3.AuthSession?> me({required int appUserId}) =>
      caller.callServerEndpoint<_i3.AuthSession?>(
        'auth',
        'me',
        {'appUserId': appUserId},
      );
}

/// {@category Endpoint}
class EndpointBootstrap extends _i1.EndpointRef {
  EndpointBootstrap(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'bootstrap';

  _i2.Future<String> seedDemoData({required String bootstrapKey}) =>
      caller.callServerEndpoint<String>(
        'bootstrap',
        'seedDemoData',
        {'bootstrapKey': bootstrapKey},
      );
}

/// {@category Endpoint}
class EndpointChat extends _i1.EndpointRef {
  EndpointChat(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  _i2.Future<List<_i4.ChatConversation>> listConversations({
    required String organizationId,
    required String actorId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i4.ChatConversation>>(
        'chat',
        'listConversations',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i4.ChatConversation> getConversation({
    required String organizationId,
    required String actorId,
    required int conversationId,
  }) =>
      caller.callServerEndpoint<_i4.ChatConversation>(
        'chat',
        'getConversation',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'conversationId': conversationId,
        },
      );

  _i2.Future<_i4.ChatConversation> createConversation({
    required String organizationId,
    required String actorId,
    required String conversationType,
    String? title,
    int? relatedChildId,
    int? relatedClassroomId,
    required List<int> participantUserIds,
  }) =>
      caller.callServerEndpoint<_i4.ChatConversation>(
        'chat',
        'createConversation',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'conversationType': conversationType,
          'title': title,
          'relatedChildId': relatedChildId,
          'relatedClassroomId': relatedClassroomId,
          'participantUserIds': participantUserIds,
        },
      );

  _i2.Future<_i5.ChatMessage> sendMessage({
    required String organizationId,
    required String actorId,
    required String conversationId,
    required String content,
  }) =>
      caller.callServerEndpoint<_i5.ChatMessage>(
        'chat',
        'sendMessage',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'conversationId': conversationId,
          'content': content,
        },
      );

  _i2.Future<List<_i5.ChatMessage>> listMessages({
    required String organizationId,
    required String actorId,
    required String conversationId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i5.ChatMessage>>(
        'chat',
        'listMessages',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'conversationId': conversationId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<void> markConversationRead({
    required String organizationId,
    required String actorId,
    required int conversationId,
    int? lastReadMessageId,
  }) =>
      caller.callServerEndpoint<void>(
        'chat',
        'markConversationRead',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'conversationId': conversationId,
          'lastReadMessageId': lastReadMessageId,
        },
      );

  _i2.Future<Map<String, int>> unreadCounts({
    required String organizationId,
    required String actorId,
  }) =>
      caller.callServerEndpoint<Map<String, int>>(
        'chat',
        'unreadCounts',
        {
          'organizationId': organizationId,
          'actorId': actorId,
        },
      );
}

/// {@category Endpoint}
class EndpointChild extends _i1.EndpointRef {
  EndpointChild(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'child';

  _i2.Future<List<_i6.Child>> listChildren({
    required String organizationId,
    required String actorId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i6.Child>>(
        'child',
        'listChildren',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i6.Child> createChild({
    required String organizationId,
    required String actorId,
    required String firstName,
    required String lastName,
    required DateTime dateOfBirth,
  }) =>
      caller.callServerEndpoint<_i6.Child>(
        'child',
        'createChild',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth,
        },
      );

  _i2.Future<_i6.Child> getChild({
    required String organizationId,
    required String actorId,
    required int childId,
  }) =>
      caller.callServerEndpoint<_i6.Child>(
        'child',
        'getChild',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
        },
      );

  _i2.Future<_i6.Child> updateChild({
    required String organizationId,
    required String actorId,
    required int childId,
    String? firstName,
    String? lastName,
    DateTime? dateOfBirth,
    String? status,
    String? medicalNotes,
    String? dietaryNotes,
    String? allergies,
  }) =>
      caller.callServerEndpoint<_i6.Child>(
        'child',
        'updateChild',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'firstName': firstName,
          'lastName': lastName,
          'dateOfBirth': dateOfBirth,
          'status': status,
          'medicalNotes': medicalNotes,
          'dietaryNotes': dietaryNotes,
          'allergies': allergies,
        },
      );

  _i2.Future<_i7.ChildProfileOverview> getChildProfileOverview({
    required String organizationId,
    required String actorId,
    required int childId,
  }) =>
      caller.callServerEndpoint<_i7.ChildProfileOverview>(
        'child',
        'getChildProfileOverview',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
        },
      );
}

/// {@category Endpoint}
class EndpointChildTimeline extends _i1.EndpointRef {
  EndpointChildTimeline(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'childTimeline';

  _i2.Future<List<_i8.ChildTimelineItem>> getChildTimeline({
    required String organizationId,
    required String actorId,
    required int childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i8.ChildTimelineItem>>(
        'childTimeline',
        'getChildTimeline',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );
}

/// {@category Endpoint}
class EndpointClassroom extends _i1.EndpointRef {
  EndpointClassroom(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'classroom';

  _i2.Future<List<_i9.Classroom>> listClassrooms({
    required String organizationId,
    required String actorId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i9.Classroom>>(
        'classroom',
        'listClassrooms',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i9.Classroom> createClassroom({
    required String organizationId,
    required String actorId,
    required String name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    required int capacity,
    String? color,
  }) =>
      caller.callServerEndpoint<_i9.Classroom>(
        'classroom',
        'createClassroom',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'name': name,
          'description': description,
          'ageGroupMin': ageGroupMin,
          'ageGroupMax': ageGroupMax,
          'capacity': capacity,
          'color': color,
        },
      );

  _i2.Future<_i9.Classroom> updateClassroom({
    required String organizationId,
    required String actorId,
    required int classroomId,
    String? name,
    String? description,
    int? ageGroupMin,
    int? ageGroupMax,
    int? capacity,
    String? color,
    String? status,
  }) =>
      caller.callServerEndpoint<_i9.Classroom>(
        'classroom',
        'updateClassroom',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'classroomId': classroomId,
          'name': name,
          'description': description,
          'ageGroupMin': ageGroupMin,
          'ageGroupMax': ageGroupMax,
          'capacity': capacity,
          'color': color,
          'status': status,
        },
      );

  _i2.Future<_i10.ClassroomAssignment> assignChildToClassroom({
    required String organizationId,
    required String actorId,
    required int classroomId,
    required int childId,
  }) =>
      caller.callServerEndpoint<_i10.ClassroomAssignment>(
        'classroom',
        'assignChildToClassroom',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'classroomId': classroomId,
          'childId': childId,
        },
      );

  _i2.Future<List<_i10.ClassroomAssignment>> listAssignments({
    required String organizationId,
    required String actorId,
    int? classroomId,
    int? childId,
    required bool onlyActive,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i10.ClassroomAssignment>>(
        'classroom',
        'listAssignments',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'classroomId': classroomId,
          'childId': childId,
          'onlyActive': onlyActive,
          'page': page,
          'pageSize': pageSize,
        },
      );
}

/// {@category Endpoint}
class EndpointDataChangeRequest extends _i1.EndpointRef {
  EndpointDataChangeRequest(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'dataChangeRequest';

  _i2.Future<_i11.DataChangeRequest> createRequest({
    required String organizationId,
    required String actorId,
    int? targetChildId,
    required String requestType,
    required String requestPayload,
  }) =>
      caller.callServerEndpoint<_i11.DataChangeRequest>(
        'dataChangeRequest',
        'createRequest',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'targetChildId': targetChildId,
          'requestType': requestType,
          'requestPayload': requestPayload,
        },
      );

  _i2.Future<List<_i11.DataChangeRequest>> myRequests({
    required String organizationId,
    required String actorId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i11.DataChangeRequest>>(
        'dataChangeRequest',
        'myRequests',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<List<_i11.DataChangeRequest>> listRequestsForReview({
    required String organizationId,
    required String actorId,
    String? status,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i11.DataChangeRequest>>(
        'dataChangeRequest',
        'listRequestsForReview',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'status': status,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i11.DataChangeRequest> getRequest({
    required String organizationId,
    required String actorId,
    required int requestId,
  }) =>
      caller.callServerEndpoint<_i11.DataChangeRequest>(
        'dataChangeRequest',
        'getRequest',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'requestId': requestId,
        },
      );

  _i2.Future<_i11.DataChangeRequest> updateRequestStatus({
    required String organizationId,
    required String actorId,
    required int requestId,
    required String status,
    String? resolutionNote,
  }) =>
      caller.callServerEndpoint<_i11.DataChangeRequest>(
        'dataChangeRequest',
        'updateRequestStatus',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'requestId': requestId,
          'status': status,
          'resolutionNote': resolutionNote,
        },
      );
}

/// {@category Endpoint}
class EndpointDocument extends _i1.EndpointRef {
  EndpointDocument(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'document';

  _i2.Future<List<_i12.OrganizationDocument>> listOrganizationDocuments({
    required String organizationId,
    required String actorId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i12.OrganizationDocument>>(
        'document',
        'listOrganizationDocuments',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i12.OrganizationDocument> createOrganizationDocument({
    required String organizationId,
    required String actorId,
    required String title,
    String? description,
    required String visibility,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    String? storagePath,
  }) =>
      caller.callServerEndpoint<_i12.OrganizationDocument>(
        'document',
        'createOrganizationDocument',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'title': title,
          'description': description,
          'visibility': visibility,
          'originalName': originalName,
          'mimeType': mimeType,
          'sizeBytes': sizeBytes,
          'storagePath': storagePath,
        },
      );

  _i2.Future<List<_i13.ChildDocument>> listChildDocuments({
    required String organizationId,
    required String actorId,
    required int childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i13.ChildDocument>>(
        'document',
        'listChildDocuments',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i13.ChildDocument> createChildDocument({
    required String organizationId,
    required String actorId,
    required int childId,
    required String title,
    String? description,
    required bool visibleToGuardians,
    required String originalName,
    required String mimeType,
    required int sizeBytes,
    String? storagePath,
  }) =>
      caller.callServerEndpoint<_i13.ChildDocument>(
        'document',
        'createChildDocument',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'title': title,
          'description': description,
          'visibleToGuardians': visibleToGuardians,
          'originalName': originalName,
          'mimeType': mimeType,
          'sizeBytes': sizeBytes,
          'storagePath': storagePath,
        },
      );

  _i2.Future<String> resolveFileDownloadUrl({
    required String organizationId,
    required String actorId,
    required int fileAssetId,
  }) =>
      caller.callServerEndpoint<String>(
        'document',
        'resolveFileDownloadUrl',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'fileAssetId': fileAssetId,
        },
      );
}

/// {@category Endpoint}
class EndpointExperience extends _i1.EndpointRef {
  EndpointExperience(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'experience';

  _i2.Future<_i14.UserOnboardingState?> getOnboardingState({
    required String organizationId,
    required String actorId,
  }) =>
      caller.callServerEndpoint<_i14.UserOnboardingState?>(
        'experience',
        'getOnboardingState',
        {
          'organizationId': organizationId,
          'actorId': actorId,
        },
      );

  _i2.Future<_i14.UserOnboardingState> completeOnboarding({
    required String organizationId,
    required String actorId,
    required bool acceptTerms,
  }) =>
      caller.callServerEndpoint<_i14.UserOnboardingState>(
        'experience',
        'completeOnboarding',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'acceptTerms': acceptTerms,
        },
      );

  _i2.Future<_i15.Organization> getCenterInfo({
    required String organizationId,
    required String actorId,
  }) =>
      caller.callServerEndpoint<_i15.Organization>(
        'experience',
        'getCenterInfo',
        {
          'organizationId': organizationId,
          'actorId': actorId,
        },
      );

  _i2.Future<List<_i16.MenuEntry>> listMenuEntries({
    required String organizationId,
    required String actorId,
    DateTime? from,
    DateTime? to,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i16.MenuEntry>>(
        'experience',
        'listMenuEntries',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'from': from,
          'to': to,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i16.MenuEntry?> getMenuEntry({
    required String organizationId,
    required String actorId,
    required int menuEntryId,
  }) =>
      caller.callServerEndpoint<_i16.MenuEntry?>(
        'experience',
        'getMenuEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'menuEntryId': menuEntryId,
        },
      );

  _i2.Future<_i16.MenuEntry> createMenuEntry({
    required String organizationId,
    required String actorId,
    required DateTime menuDate,
    required String mealType,
    required String title,
    String? description,
    int? classroomId,
  }) =>
      caller.callServerEndpoint<_i16.MenuEntry>(
        'experience',
        'createMenuEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'menuDate': menuDate,
          'mealType': mealType,
          'title': title,
          'description': description,
          'classroomId': classroomId,
        },
      );

  _i2.Future<_i16.MenuEntry> updateMenuEntry({
    required String organizationId,
    required String actorId,
    required int menuEntryId,
    DateTime? menuDate,
    String? mealType,
    String? title,
    String? description,
    int? classroomId,
  }) =>
      caller.callServerEndpoint<_i16.MenuEntry>(
        'experience',
        'updateMenuEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'menuEntryId': menuEntryId,
          'menuDate': menuDate,
          'mealType': mealType,
          'title': title,
          'description': description,
          'classroomId': classroomId,
        },
      );
}

/// {@category Endpoint}
class EndpointGallery extends _i1.EndpointRef {
  EndpointGallery(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'gallery';

  _i2.Future<List<_i17.Gallery>> listGalleries({
    required String organizationId,
    required String actorId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i17.Gallery>>(
        'gallery',
        'listGalleries',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i17.Gallery> getGallery({
    required String organizationId,
    required String actorId,
    required int galleryId,
  }) =>
      caller.callServerEndpoint<_i17.Gallery>(
        'gallery',
        'getGallery',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'galleryId': galleryId,
        },
      );

  _i2.Future<_i17.Gallery> createGallery({
    required String organizationId,
    required String actorId,
    required String title,
    String? description,
    required String audienceType,
    int? audienceClassroomId,
    int? audienceChildId,
  }) =>
      caller.callServerEndpoint<_i17.Gallery>(
        'gallery',
        'createGallery',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'title': title,
          'description': description,
          'audienceType': audienceType,
          'audienceClassroomId': audienceClassroomId,
          'audienceChildId': audienceChildId,
        },
      );

  _i2.Future<_i17.Gallery> updateGallery({
    required String organizationId,
    required String actorId,
    required int galleryId,
    String? title,
    String? description,
    String? audienceType,
    int? audienceClassroomId,
    int? audienceChildId,
    bool? isPublished,
  }) =>
      caller.callServerEndpoint<_i17.Gallery>(
        'gallery',
        'updateGallery',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'galleryId': galleryId,
          'title': title,
          'description': description,
          'audienceType': audienceType,
          'audienceClassroomId': audienceClassroomId,
          'audienceChildId': audienceChildId,
          'isPublished': isPublished,
        },
      );

  _i2.Future<_i18.GalleryItem> addGalleryItem({
    required String organizationId,
    required String actorId,
    required int galleryId,
    required int fileAssetId,
    String? caption,
    int? sortOrder,
  }) =>
      caller.callServerEndpoint<_i18.GalleryItem>(
        'gallery',
        'addGalleryItem',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'galleryId': galleryId,
          'fileAssetId': fileAssetId,
          'caption': caption,
          'sortOrder': sortOrder,
        },
      );

  _i2.Future<List<_i18.GalleryItem>> listGalleryItems({
    required String organizationId,
    required String actorId,
    required int galleryId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i18.GalleryItem>>(
        'gallery',
        'listGalleryItems',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'galleryId': galleryId,
          'page': page,
          'pageSize': pageSize,
        },
      );
}

/// {@category Endpoint}
class EndpointHabit extends _i1.EndpointRef {
  EndpointHabit(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'habit';

  _i2.Future<List<_i19.MealEntry>> listMealsByChild({
    required String organizationId,
    required String actorId,
    required int childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i19.MealEntry>>(
        'habit',
        'listMealsByChild',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i19.MealEntry> createMealEntry({
    required String organizationId,
    required String actorId,
    required int childId,
    required String mealType,
    required String consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i19.MealEntry>(
        'habit',
        'createMealEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'mealType': mealType,
          'consumptionLevel': consumptionLevel,
          'recordedAt': recordedAt,
          'menuItems': menuItems,
          'notes': notes,
        },
      );

  _i2.Future<_i19.MealEntry> updateMealEntry({
    required String organizationId,
    required String actorId,
    required int mealEntryId,
    String? mealType,
    String? consumptionLevel,
    DateTime? recordedAt,
    String? menuItems,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i19.MealEntry>(
        'habit',
        'updateMealEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'mealEntryId': mealEntryId,
          'mealType': mealType,
          'consumptionLevel': consumptionLevel,
          'recordedAt': recordedAt,
          'menuItems': menuItems,
          'notes': notes,
        },
      );

  _i2.Future<List<_i20.NapEntry>> listNapsByChild({
    required String organizationId,
    required String actorId,
    required int childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i20.NapEntry>>(
        'habit',
        'listNapsByChild',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i20.NapEntry> createNapEntry({
    required String organizationId,
    required String actorId,
    required int childId,
    required DateTime startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i20.NapEntry>(
        'habit',
        'createNapEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'startedAt': startedAt,
          'endedAt': endedAt,
          'durationMinutes': durationMinutes,
          'sleepQuality': sleepQuality,
          'notes': notes,
        },
      );

  _i2.Future<_i20.NapEntry> updateNapEntry({
    required String organizationId,
    required String actorId,
    required int napEntryId,
    DateTime? startedAt,
    DateTime? endedAt,
    int? durationMinutes,
    String? sleepQuality,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i20.NapEntry>(
        'habit',
        'updateNapEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'napEntryId': napEntryId,
          'startedAt': startedAt,
          'endedAt': endedAt,
          'durationMinutes': durationMinutes,
          'sleepQuality': sleepQuality,
          'notes': notes,
        },
      );

  _i2.Future<List<_i21.BowelMovementEntry>> listBowelMovementsByChild({
    required String organizationId,
    required String actorId,
    required int childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i21.BowelMovementEntry>>(
        'habit',
        'listBowelMovementsByChild',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i21.BowelMovementEntry> createBowelMovementEntry({
    required String organizationId,
    required String actorId,
    required int childId,
    DateTime? eventAt,
    required String eventType,
    String? consistency,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i21.BowelMovementEntry>(
        'habit',
        'createBowelMovementEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'eventAt': eventAt,
          'eventType': eventType,
          'consistency': consistency,
          'notes': notes,
        },
      );

  _i2.Future<_i21.BowelMovementEntry> updateBowelMovementEntry({
    required String organizationId,
    required String actorId,
    required int entryId,
    DateTime? eventAt,
    String? eventType,
    String? consistency,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i21.BowelMovementEntry>(
        'habit',
        'updateBowelMovementEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'entryId': entryId,
          'eventAt': eventAt,
          'eventType': eventType,
          'consistency': consistency,
          'notes': notes,
        },
      );

  _i2.Future<_i22.ChildDailyHabits> getChildDailyHabits({
    required String organizationId,
    required String actorId,
    required int childId,
    required DateTime day,
  }) =>
      caller.callServerEndpoint<_i22.ChildDailyHabits>(
        'habit',
        'getChildDailyHabits',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'day': day,
        },
      );
}

/// {@category Endpoint}
class EndpointNotification extends _i1.EndpointRef {
  EndpointNotification(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _i2.Future<_i23.PushDeviceToken> registerDeviceToken({
    required String organizationId,
    required String actorId,
    required String token,
    required String platform,
    String? deviceId,
    String? deviceModel,
    String? appVersion,
  }) =>
      caller.callServerEndpoint<_i23.PushDeviceToken>(
        'notification',
        'registerDeviceToken',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'token': token,
          'platform': platform,
          'deviceId': deviceId,
          'deviceModel': deviceModel,
          'appVersion': appVersion,
        },
      );

  _i2.Future<void> removeDeviceToken({
    required String organizationId,
    required String actorId,
    required String token,
  }) =>
      caller.callServerEndpoint<void>(
        'notification',
        'removeDeviceToken',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'token': token,
        },
      );

  _i2.Future<List<_i24.NotificationRecord>> myNotifications({
    required String organizationId,
    required String actorId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i24.NotificationRecord>>(
        'notification',
        'myNotifications',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<void> markNotificationRead({
    required String organizationId,
    required String actorId,
    required int notificationId,
  }) =>
      caller.callServerEndpoint<void>(
        'notification',
        'markNotificationRead',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'notificationId': notificationId,
        },
      );

  _i2.Future<int> createSegmentedNotification({
    required String organizationId,
    required String actorId,
    required String title,
    required String body,
    required String category,
    required String targetScope,
    int? targetClassroomId,
    int? targetChildId,
    int? targetUserId,
  }) =>
      caller.callServerEndpoint<int>(
        'notification',
        'createSegmentedNotification',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'title': title,
          'body': body,
          'category': category,
          'targetScope': targetScope,
          'targetClassroomId': targetClassroomId,
          'targetChildId': targetChildId,
          'targetUserId': targetUserId,
        },
      );
}

/// {@category Endpoint}
class EndpointOrganization extends _i1.EndpointRef {
  EndpointOrganization(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'organization';

  _i2.Future<List<_i15.Organization>> listOrganizations({
    required String actorRole,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i15.Organization>>(
        'organization',
        'listOrganizations',
        {
          'actorRole': actorRole,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i15.Organization?> getOrganization({
    required String organizationId,
    required String actorRole,
  }) =>
      caller.callServerEndpoint<_i15.Organization?>(
        'organization',
        'getOrganization',
        {
          'organizationId': organizationId,
          'actorRole': actorRole,
        },
      );

  _i2.Future<_i15.Organization> createOrganization({
    required String actorRole,
    required String name,
    required String slug,
    required String contactEmail,
  }) =>
      caller.callServerEndpoint<_i15.Organization>(
        'organization',
        'createOrganization',
        {
          'actorRole': actorRole,
          'name': name,
          'slug': slug,
          'contactEmail': contactEmail,
        },
      );
}

/// {@category Endpoint}
class EndpointPedagogicalReport extends _i1.EndpointRef {
  EndpointPedagogicalReport(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'pedagogicalReport';

  _i2.Future<List<_i25.PedagogicalReport>> listReportsByChild({
    required String organizationId,
    required String actorId,
    required int childId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i25.PedagogicalReport>>(
        'pedagogicalReport',
        'listReportsByChild',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i25.PedagogicalReport> getReport({
    required String organizationId,
    required String actorId,
    required int reportId,
  }) =>
      caller.callServerEndpoint<_i25.PedagogicalReport>(
        'pedagogicalReport',
        'getReport',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'reportId': reportId,
        },
      );

  _i2.Future<_i25.PedagogicalReport> createReport({
    required String organizationId,
    required String actorId,
    required int childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    required String status,
    required String visibility,
  }) =>
      caller.callServerEndpoint<_i25.PedagogicalReport>(
        'pedagogicalReport',
        'createReport',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'childId': childId,
          'reportDate': reportDate,
          'title': title,
          'summary': summary,
          'body': body,
          'status': status,
          'visibility': visibility,
        },
      );

  _i2.Future<_i25.PedagogicalReport> updateReport({
    required String organizationId,
    required String actorId,
    required int reportId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
  }) =>
      caller.callServerEndpoint<_i25.PedagogicalReport>(
        'pedagogicalReport',
        'updateReport',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'reportId': reportId,
          'reportDate': reportDate,
          'title': title,
          'summary': summary,
          'body': body,
          'status': status,
          'visibility': visibility,
        },
      );
}

/// {@category Endpoint}
class EndpointTimeTracking extends _i1.EndpointRef {
  EndpointTimeTracking(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'timeTracking';

  _i2.Future<_i26.TimeEntry> checkIn({
    required String organizationId,
    required String actorId,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i26.TimeEntry>(
        'timeTracking',
        'checkIn',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'notes': notes,
        },
      );

  _i2.Future<_i26.TimeEntry> checkOut({
    required String organizationId,
    required String actorId,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i26.TimeEntry>(
        'timeTracking',
        'checkOut',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'notes': notes,
        },
      );

  _i2.Future<List<_i26.TimeEntry>> myEntries({
    required String organizationId,
    required String actorId,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i26.TimeEntry>>(
        'timeTracking',
        'myEntries',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<List<_i26.TimeEntry>> listEntries({
    required String organizationId,
    required String actorId,
    String? userId,
    DateTime? from,
    DateTime? to,
    required int page,
    required int pageSize,
  }) =>
      caller.callServerEndpoint<List<_i26.TimeEntry>>(
        'timeTracking',
        'listEntries',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'userId': userId,
          'from': from,
          'to': to,
          'page': page,
          'pageSize': pageSize,
        },
      );

  _i2.Future<_i26.TimeEntry> getEntry({
    required String organizationId,
    required String actorId,
    required int entryId,
  }) =>
      caller.callServerEndpoint<_i26.TimeEntry>(
        'timeTracking',
        'getEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'entryId': entryId,
        },
      );

  _i2.Future<_i26.TimeEntry> correctEntry({
    required String organizationId,
    required String actorId,
    required int targetEntryId,
    required String correctedEntryType,
    required String correctionReason,
    String? notes,
  }) =>
      caller.callServerEndpoint<_i26.TimeEntry>(
        'timeTracking',
        'correctEntry',
        {
          'organizationId': organizationId,
          'actorId': actorId,
          'targetEntryId': targetEntryId,
          'correctedEntryType': correctedEntryType,
          'correctionReason': correctionReason,
          'notes': notes,
        },
      );
}

class Modules {
  Modules(Client client) {
    auth = _i27.Caller(client);
  }

  late final _i27.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i28.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    auth = EndpointAuth(this);
    bootstrap = EndpointBootstrap(this);
    chat = EndpointChat(this);
    child = EndpointChild(this);
    childTimeline = EndpointChildTimeline(this);
    classroom = EndpointClassroom(this);
    dataChangeRequest = EndpointDataChangeRequest(this);
    document = EndpointDocument(this);
    experience = EndpointExperience(this);
    gallery = EndpointGallery(this);
    habit = EndpointHabit(this);
    notification = EndpointNotification(this);
    organization = EndpointOrganization(this);
    pedagogicalReport = EndpointPedagogicalReport(this);
    timeTracking = EndpointTimeTracking(this);
    modules = Modules(this);
  }

  late final EndpointAuth auth;

  late final EndpointBootstrap bootstrap;

  late final EndpointChat chat;

  late final EndpointChild child;

  late final EndpointChildTimeline childTimeline;

  late final EndpointClassroom classroom;

  late final EndpointDataChangeRequest dataChangeRequest;

  late final EndpointDocument document;

  late final EndpointExperience experience;

  late final EndpointGallery gallery;

  late final EndpointHabit habit;

  late final EndpointNotification notification;

  late final EndpointOrganization organization;

  late final EndpointPedagogicalReport pedagogicalReport;

  late final EndpointTimeTracking timeTracking;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'auth': auth,
        'bootstrap': bootstrap,
        'chat': chat,
        'child': child,
        'childTimeline': childTimeline,
        'classroom': classroom,
        'dataChangeRequest': dataChangeRequest,
        'document': document,
        'experience': experience,
        'gallery': gallery,
        'habit': habit,
        'notification': notification,
        'organization': organization,
        'pedagogicalReport': pedagogicalReport,
        'timeTracking': timeTracking,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
