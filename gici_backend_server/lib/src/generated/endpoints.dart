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
import '../endpoints/absence_endpoint.dart' as _i2;
import '../endpoints/auth_endpoint.dart' as _i3;
import '../endpoints/bootstrap_endpoint.dart' as _i4;
import '../endpoints/calendar_endpoint.dart' as _i5;
import '../endpoints/chat_endpoint.dart' as _i6;
import '../endpoints/child_endpoint.dart' as _i7;
import '../endpoints/child_timeline_endpoint.dart' as _i8;
import '../endpoints/classroom_endpoint.dart' as _i9;
import '../endpoints/consent_endpoint.dart' as _i10;
import '../endpoints/dashboard_endpoint.dart' as _i11;
import '../endpoints/data_change_request_endpoint.dart' as _i12;
import '../endpoints/document_endpoint.dart' as _i13;
import '../endpoints/experience_endpoint.dart' as _i14;
import '../endpoints/gallery_endpoint.dart' as _i15;
import '../endpoints/habit_endpoint.dart' as _i16;
import '../endpoints/notification_endpoint.dart' as _i17;
import '../endpoints/organization_endpoint.dart' as _i18;
import '../endpoints/pedagogical_report_endpoint.dart' as _i19;
import '../endpoints/staff_endpoint.dart' as _i20;
import '../endpoints/tariff_endpoint.dart' as _i21;
import '../endpoints/time_tracking_endpoint.dart' as _i22;
import 'package:uuid/uuid_value.dart' as _i23;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i24;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'absence': _i2.AbsenceEndpoint()
        ..initialize(
          server,
          'absence',
          null,
        ),
      'auth': _i3.AuthEndpoint()
        ..initialize(
          server,
          'auth',
          null,
        ),
      'bootstrap': _i4.BootstrapEndpoint()
        ..initialize(
          server,
          'bootstrap',
          null,
        ),
      'calendar': _i5.CalendarEndpoint()
        ..initialize(
          server,
          'calendar',
          null,
        ),
      'chat': _i6.ChatEndpoint()
        ..initialize(
          server,
          'chat',
          null,
        ),
      'child': _i7.ChildEndpoint()
        ..initialize(
          server,
          'child',
          null,
        ),
      'childTimeline': _i8.ChildTimelineEndpoint()
        ..initialize(
          server,
          'childTimeline',
          null,
        ),
      'classroom': _i9.ClassroomEndpoint()
        ..initialize(
          server,
          'classroom',
          null,
        ),
      'consent': _i10.ConsentEndpoint()
        ..initialize(
          server,
          'consent',
          null,
        ),
      'dashboard': _i11.DashboardEndpoint()
        ..initialize(
          server,
          'dashboard',
          null,
        ),
      'dataChangeRequest': _i12.DataChangeRequestEndpoint()
        ..initialize(
          server,
          'dataChangeRequest',
          null,
        ),
      'document': _i13.DocumentEndpoint()
        ..initialize(
          server,
          'document',
          null,
        ),
      'experience': _i14.ExperienceEndpoint()
        ..initialize(
          server,
          'experience',
          null,
        ),
      'gallery': _i15.GalleryEndpoint()
        ..initialize(
          server,
          'gallery',
          null,
        ),
      'habit': _i16.HabitEndpoint()
        ..initialize(
          server,
          'habit',
          null,
        ),
      'notification': _i17.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'organization': _i18.OrganizationEndpoint()
        ..initialize(
          server,
          'organization',
          null,
        ),
      'pedagogicalReport': _i19.PedagogicalReportEndpoint()
        ..initialize(
          server,
          'pedagogicalReport',
          null,
        ),
      'staff': _i20.StaffEndpoint()
        ..initialize(
          server,
          'staff',
          null,
        ),
      'tariff': _i21.TariffEndpoint()
        ..initialize(
          server,
          'tariff',
          null,
        ),
      'timeTracking': _i22.TimeTrackingEndpoint()
        ..initialize(
          server,
          'timeTracking',
          null,
        ),
    };
    connectors['absence'] = _i1.EndpointConnector(
      name: 'absence',
      endpoint: endpoints['absence']!,
      methodConnectors: {
        'reportAbsence': _i1.MethodConnector(
          name: 'reportAbsence',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isJustified': _i1.ParameterDescription(
              name: 'isJustified',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['absence'] as _i2.AbsenceEndpoint).reportAbsence(
            session,
            childId: params['childId'],
            date: params['date'],
            reason: params['reason'],
            isJustified: params['isJustified'],
            notes: params['notes'],
          ),
        ),
        'listAbsencesByChild': _i1.MethodConnector(
          name: 'listAbsencesByChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['absence'] as _i2.AbsenceEndpoint).listAbsencesByChild(
            session,
            childId: params['childId'],
            from: params['from'],
            to: params['to'],
          ),
        ),
        'listAbsencesByDate': _i1.MethodConnector(
          name: 'listAbsencesByDate',
          params: {
            'date': _i1.ParameterDescription(
              name: 'date',
              type: _i1.getType<DateTime>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['absence'] as _i2.AbsenceEndpoint).listAbsencesByDate(
            session,
            date: params['date'],
          ),
        ),
        'listAbsencesByClassroom': _i1.MethodConnector(
          name: 'listAbsencesByClassroom',
          params: {
            'classroomId': _i1.ParameterDescription(
              name: 'classroomId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['absence'] as _i2.AbsenceEndpoint)
                  .listAbsencesByClassroom(
            session,
            classroomId: params['classroomId'],
            from: params['from'],
            to: params['to'],
          ),
        ),
      },
    );
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'signInWithEmailPassword': _i1.MethodConnector(
          name: 'signInWithEmailPassword',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i3.AuthEndpoint).signInWithEmailPassword(
            session,
            email: params['email'],
            password: params['password'],
          ),
        ),
        'me': _i1.MethodConnector(
          name: 'me',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i3.AuthEndpoint).me(session),
        ),
        'requestPasswordReset': _i1.MethodConnector(
          name: 'requestPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i3.AuthEndpoint).requestPasswordReset(
            session,
            email: params['email'],
          ),
        ),
        'resetPassword': _i1.MethodConnector(
          name: 'resetPassword',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['auth'] as _i3.AuthEndpoint).resetPassword(
            session,
            email: params['email'],
            code: params['code'],
            newPassword: params['newPassword'],
          ),
        ),
      },
    );
    connectors['bootstrap'] = _i1.EndpointConnector(
      name: 'bootstrap',
      endpoint: endpoints['bootstrap']!,
      methodConnectors: {
        'seedDemoData': _i1.MethodConnector(
          name: 'seedDemoData',
          params: {
            'bootstrapKey': _i1.ParameterDescription(
              name: 'bootstrapKey',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['bootstrap'] as _i4.BootstrapEndpoint).seedDemoData(
            session,
            bootstrapKey: params['bootstrapKey'],
          ),
        )
      },
    );
    connectors['calendar'] = _i1.EndpointConnector(
      name: 'calendar',
      endpoint: endpoints['calendar']!,
      methodConnectors: {
        'listEvents': _i1.MethodConnector(
          name: 'listEvents',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['calendar'] as _i5.CalendarEndpoint).listEvents(
            session,
            from: params['from'],
            to: params['to'],
          ),
        ),
        'createEvent': _i1.MethodConnector(
          name: 'createEvent',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'eventDate': _i1.ParameterDescription(
              name: 'eventDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'isRecurring': _i1.ParameterDescription(
              name: 'isRecurring',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['calendar'] as _i5.CalendarEndpoint).createEvent(
            session,
            title: params['title'],
            description: params['description'],
            eventDate: params['eventDate'],
            endDate: params['endDate'],
            eventType: params['eventType'],
            isRecurring: params['isRecurring'],
          ),
        ),
        'updateEvent': _i1.MethodConnector(
          name: 'updateEvent',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'eventDate': _i1.ParameterDescription(
              name: 'eventDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isRecurring': _i1.ParameterDescription(
              name: 'isRecurring',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['calendar'] as _i5.CalendarEndpoint).updateEvent(
            session,
            eventId: params['eventId'],
            title: params['title'],
            description: params['description'],
            eventDate: params['eventDate'],
            endDate: params['endDate'],
            eventType: params['eventType'],
            isRecurring: params['isRecurring'],
          ),
        ),
        'deleteEvent': _i1.MethodConnector(
          name: 'deleteEvent',
          params: {
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['calendar'] as _i5.CalendarEndpoint).deleteEvent(
            session,
            eventId: params['eventId'],
          ),
        ),
      },
    );
    connectors['chat'] = _i1.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'listConversations': _i1.MethodConnector(
          name: 'listConversations',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).listConversations(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'getConversation': _i1.MethodConnector(
          name: 'getConversation',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).getConversation(
            session,
            conversationId: params['conversationId'],
          ),
        ),
        'createConversation': _i1.MethodConnector(
          name: 'createConversation',
          params: {
            'conversationType': _i1.ParameterDescription(
              name: 'conversationType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'relatedChildId': _i1.ParameterDescription(
              name: 'relatedChildId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'relatedClassroomId': _i1.ParameterDescription(
              name: 'relatedClassroomId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'participantUserIds': _i1.ParameterDescription(
              name: 'participantUserIds',
              type: _i1.getType<List<_i23.UuidValue>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).createConversation(
            session,
            conversationType: params['conversationType'],
            title: params['title'],
            relatedChildId: params['relatedChildId'],
            relatedClassroomId: params['relatedClassroomId'],
            participantUserIds: params['participantUserIds'],
          ),
        ),
        'sendMessage': _i1.MethodConnector(
          name: 'sendMessage',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).sendMessage(
            session,
            conversationId: params['conversationId'],
            content: params['content'],
          ),
        ),
        'listMessages': _i1.MethodConnector(
          name: 'listMessages',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).listMessages(
            session,
            conversationId: params['conversationId'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'markConversationRead': _i1.MethodConnector(
          name: 'markConversationRead',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'lastReadMessageId': _i1.ParameterDescription(
              name: 'lastReadMessageId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).markConversationRead(
            session,
            conversationId: params['conversationId'],
            lastReadMessageId: params['lastReadMessageId'],
          ),
        ),
        'unreadCounts': _i1.MethodConnector(
          name: 'unreadCounts',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).unreadCounts(session),
        ),
      },
    );
    connectors['child'] = _i1.EndpointConnector(
      name: 'child',
      endpoint: endpoints['child']!,
      methodConnectors: {
        'listChildren': _i1.MethodConnector(
          name: 'listChildren',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['child'] as _i7.ChildEndpoint).listChildren(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createChild': _i1.MethodConnector(
          name: 'createChild',
          params: {
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'dateOfBirth': _i1.ParameterDescription(
              name: 'dateOfBirth',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['child'] as _i7.ChildEndpoint).createChild(
            session,
            firstName: params['firstName'],
            lastName: params['lastName'],
            dateOfBirth: params['dateOfBirth'],
          ),
        ),
        'getChild': _i1.MethodConnector(
          name: 'getChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['child'] as _i7.ChildEndpoint).getChild(
            session,
            childId: params['childId'],
          ),
        ),
        'updateChild': _i1.MethodConnector(
          name: 'updateChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'dateOfBirth': _i1.ParameterDescription(
              name: 'dateOfBirth',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'medicalNotes': _i1.ParameterDescription(
              name: 'medicalNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'dietaryNotes': _i1.ParameterDescription(
              name: 'dietaryNotes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'allergies': _i1.ParameterDescription(
              name: 'allergies',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['child'] as _i7.ChildEndpoint).updateChild(
            session,
            childId: params['childId'],
            firstName: params['firstName'],
            lastName: params['lastName'],
            dateOfBirth: params['dateOfBirth'],
            status: params['status'],
            medicalNotes: params['medicalNotes'],
            dietaryNotes: params['dietaryNotes'],
            allergies: params['allergies'],
          ),
        ),
        'getChildProfileOverview': _i1.MethodConnector(
          name: 'getChildProfileOverview',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['child'] as _i7.ChildEndpoint).getChildProfileOverview(
            session,
            childId: params['childId'],
          ),
        ),
        'linkGuardian': _i1.MethodConnector(
          name: 'linkGuardian',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'relation': _i1.ParameterDescription(
              name: 'relation',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isPrimary': _i1.ParameterDescription(
              name: 'isPrimary',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['child'] as _i7.ChildEndpoint).linkGuardian(
            session,
            childId: params['childId'],
            email: params['email'],
            firstName: params['firstName'],
            lastName: params['lastName'],
            relation: params['relation'],
            phone: params['phone'],
            password: params['password'],
            isPrimary: params['isPrimary'],
          ),
        ),
        'listGuardians': _i1.MethodConnector(
          name: 'listGuardians',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['child'] as _i7.ChildEndpoint).listGuardians(
            session,
            childId: params['childId'],
          ),
        ),
      },
    );
    connectors['childTimeline'] = _i1.EndpointConnector(
      name: 'childTimeline',
      endpoint: endpoints['childTimeline']!,
      methodConnectors: {
        'getChildTimeline': _i1.MethodConnector(
          name: 'getChildTimeline',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['childTimeline'] as _i8.ChildTimelineEndpoint)
                  .getChildTimeline(
            session,
            childId: params['childId'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        )
      },
    );
    connectors['classroom'] = _i1.EndpointConnector(
      name: 'classroom',
      endpoint: endpoints['classroom']!,
      methodConnectors: {
        'listClassrooms': _i1.MethodConnector(
          name: 'listClassrooms',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classroom'] as _i9.ClassroomEndpoint).listClassrooms(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createClassroom': _i1.MethodConnector(
          name: 'createClassroom',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'ageGroupMin': _i1.ParameterDescription(
              name: 'ageGroupMin',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'ageGroupMax': _i1.ParameterDescription(
              name: 'ageGroupMax',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'capacity': _i1.ParameterDescription(
              name: 'capacity',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'color': _i1.ParameterDescription(
              name: 'color',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classroom'] as _i9.ClassroomEndpoint).createClassroom(
            session,
            name: params['name'],
            description: params['description'],
            ageGroupMin: params['ageGroupMin'],
            ageGroupMax: params['ageGroupMax'],
            capacity: params['capacity'],
            color: params['color'],
          ),
        ),
        'updateClassroom': _i1.MethodConnector(
          name: 'updateClassroom',
          params: {
            'classroomId': _i1.ParameterDescription(
              name: 'classroomId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'ageGroupMin': _i1.ParameterDescription(
              name: 'ageGroupMin',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'ageGroupMax': _i1.ParameterDescription(
              name: 'ageGroupMax',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'capacity': _i1.ParameterDescription(
              name: 'capacity',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'color': _i1.ParameterDescription(
              name: 'color',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classroom'] as _i9.ClassroomEndpoint).updateClassroom(
            session,
            classroomId: params['classroomId'],
            name: params['name'],
            description: params['description'],
            ageGroupMin: params['ageGroupMin'],
            ageGroupMax: params['ageGroupMax'],
            capacity: params['capacity'],
            color: params['color'],
            status: params['status'],
          ),
        ),
        'assignChildToClassroom': _i1.MethodConnector(
          name: 'assignChildToClassroom',
          params: {
            'classroomId': _i1.ParameterDescription(
              name: 'classroomId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classroom'] as _i9.ClassroomEndpoint)
                  .assignChildToClassroom(
            session,
            classroomId: params['classroomId'],
            childId: params['childId'],
          ),
        ),
        'listAssignments': _i1.MethodConnector(
          name: 'listAssignments',
          params: {
            'classroomId': _i1.ParameterDescription(
              name: 'classroomId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'onlyActive': _i1.ParameterDescription(
              name: 'onlyActive',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['classroom'] as _i9.ClassroomEndpoint).listAssignments(
            session,
            classroomId: params['classroomId'],
            childId: params['childId'],
            onlyActive: params['onlyActive'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
      },
    );
    connectors['consent'] = _i1.EndpointConnector(
      name: 'consent',
      endpoint: endpoints['consent']!,
      methodConnectors: {
        'getMyConsents': _i1.MethodConnector(
          name: 'getMyConsents',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['consent'] as _i10.ConsentEndpoint)
                  .getMyConsents(session),
        ),
        'acceptConsent': _i1.MethodConnector(
          name: 'acceptConsent',
          params: {
            'consentType': _i1.ParameterDescription(
              name: 'consentType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['consent'] as _i10.ConsentEndpoint).acceptConsent(
            session,
            consentType: params['consentType'],
            childId: params['childId'],
          ),
        ),
        'revokeConsent': _i1.MethodConnector(
          name: 'revokeConsent',
          params: {
            'consentType': _i1.ParameterDescription(
              name: 'consentType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['consent'] as _i10.ConsentEndpoint).revokeConsent(
            session,
            consentType: params['consentType'],
            childId: params['childId'],
          ),
        ),
        'listConsentsForChild': _i1.MethodConnector(
          name: 'listConsentsForChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['consent'] as _i10.ConsentEndpoint)
                  .listConsentsForChild(
            session,
            childId: params['childId'],
          ),
        ),
      },
    );
    connectors['dashboard'] = _i1.EndpointConnector(
      name: 'dashboard',
      endpoint: endpoints['dashboard']!,
      methodConnectors: {
        'getSummary': _i1.MethodConnector(
          name: 'getSummary',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dashboard'] as _i11.DashboardEndpoint)
                  .getSummary(session),
        )
      },
    );
    connectors['dataChangeRequest'] = _i1.EndpointConnector(
      name: 'dataChangeRequest',
      endpoint: endpoints['dataChangeRequest']!,
      methodConnectors: {
        'createRequest': _i1.MethodConnector(
          name: 'createRequest',
          params: {
            'targetChildId': _i1.ParameterDescription(
              name: 'targetChildId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'requestType': _i1.ParameterDescription(
              name: 'requestType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'requestPayload': _i1.ParameterDescription(
              name: 'requestPayload',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dataChangeRequest'] as _i12.DataChangeRequestEndpoint)
                  .createRequest(
            session,
            targetChildId: params['targetChildId'],
            requestType: params['requestType'],
            requestPayload: params['requestPayload'],
          ),
        ),
        'myRequests': _i1.MethodConnector(
          name: 'myRequests',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dataChangeRequest'] as _i12.DataChangeRequestEndpoint)
                  .myRequests(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'listRequestsForReview': _i1.MethodConnector(
          name: 'listRequestsForReview',
          params: {
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dataChangeRequest'] as _i12.DataChangeRequestEndpoint)
                  .listRequestsForReview(
            session,
            status: params['status'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'getRequest': _i1.MethodConnector(
          name: 'getRequest',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dataChangeRequest'] as _i12.DataChangeRequestEndpoint)
                  .getRequest(
            session,
            requestId: params['requestId'],
          ),
        ),
        'updateRequestStatus': _i1.MethodConnector(
          name: 'updateRequestStatus',
          params: {
            'requestId': _i1.ParameterDescription(
              name: 'requestId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'resolutionNote': _i1.ParameterDescription(
              name: 'resolutionNote',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['dataChangeRequest'] as _i12.DataChangeRequestEndpoint)
                  .updateRequestStatus(
            session,
            requestId: params['requestId'],
            status: params['status'],
            resolutionNote: params['resolutionNote'],
          ),
        ),
      },
    );
    connectors['document'] = _i1.EndpointConnector(
      name: 'document',
      endpoint: endpoints['document']!,
      methodConnectors: {
        'listOrganizationDocuments': _i1.MethodConnector(
          name: 'listOrganizationDocuments',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i13.DocumentEndpoint)
                  .listOrganizationDocuments(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createOrganizationDocument': _i1.MethodConnector(
          name: 'createOrganizationDocument',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'visibility': _i1.ParameterDescription(
              name: 'visibility',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'originalName': _i1.ParameterDescription(
              name: 'originalName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'mimeType': _i1.ParameterDescription(
              name: 'mimeType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sizeBytes': _i1.ParameterDescription(
              name: 'sizeBytes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storagePath': _i1.ParameterDescription(
              name: 'storagePath',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i13.DocumentEndpoint)
                  .createOrganizationDocument(
            session,
            title: params['title'],
            description: params['description'],
            visibility: params['visibility'],
            originalName: params['originalName'],
            mimeType: params['mimeType'],
            sizeBytes: params['sizeBytes'],
            storagePath: params['storagePath'],
          ),
        ),
        'listChildDocuments': _i1.MethodConnector(
          name: 'listChildDocuments',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i13.DocumentEndpoint)
                  .listChildDocuments(
            session,
            childId: params['childId'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createChildDocument': _i1.MethodConnector(
          name: 'createChildDocument',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'visibleToGuardians': _i1.ParameterDescription(
              name: 'visibleToGuardians',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'originalName': _i1.ParameterDescription(
              name: 'originalName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'mimeType': _i1.ParameterDescription(
              name: 'mimeType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'sizeBytes': _i1.ParameterDescription(
              name: 'sizeBytes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'storagePath': _i1.ParameterDescription(
              name: 'storagePath',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i13.DocumentEndpoint)
                  .createChildDocument(
            session,
            childId: params['childId'],
            title: params['title'],
            description: params['description'],
            visibleToGuardians: params['visibleToGuardians'],
            originalName: params['originalName'],
            mimeType: params['mimeType'],
            sizeBytes: params['sizeBytes'],
            storagePath: params['storagePath'],
          ),
        ),
        'resolveFileDownloadUrl': _i1.MethodConnector(
          name: 'resolveFileDownloadUrl',
          params: {
            'fileAssetId': _i1.ParameterDescription(
              name: 'fileAssetId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['document'] as _i13.DocumentEndpoint)
                  .resolveFileDownloadUrl(
            session,
            fileAssetId: params['fileAssetId'],
          ),
        ),
      },
    );
    connectors['experience'] = _i1.EndpointConnector(
      name: 'experience',
      endpoint: endpoints['experience']!,
      methodConnectors: {
        'getOnboardingState': _i1.MethodConnector(
          name: 'getOnboardingState',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i14.ExperienceEndpoint)
                  .getOnboardingState(session),
        ),
        'completeOnboarding': _i1.MethodConnector(
          name: 'completeOnboarding',
          params: {
            'acceptTerms': _i1.ParameterDescription(
              name: 'acceptTerms',
              type: _i1.getType<bool>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i14.ExperienceEndpoint)
                  .completeOnboarding(
            session,
            acceptTerms: params['acceptTerms'],
          ),
        ),
        'getCenterInfo': _i1.MethodConnector(
          name: 'getCenterInfo',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i14.ExperienceEndpoint)
                  .getCenterInfo(session),
        ),
        'listMenuEntries': _i1.MethodConnector(
          name: 'listMenuEntries',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'menuTrack': _i1.ParameterDescription(
              name: 'menuTrack',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i14.ExperienceEndpoint)
                  .listMenuEntries(
            session,
            from: params['from'],
            to: params['to'],
            menuTrack: params['menuTrack'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'getMenuEntry': _i1.MethodConnector(
          name: 'getMenuEntry',
          params: {
            'menuEntryId': _i1.ParameterDescription(
              name: 'menuEntryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i14.ExperienceEndpoint).getMenuEntry(
            session,
            menuEntryId: params['menuEntryId'],
          ),
        ),
        'createMenuEntry': _i1.MethodConnector(
          name: 'createMenuEntry',
          params: {
            'menuDate': _i1.ParameterDescription(
              name: 'menuDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'mealType': _i1.ParameterDescription(
              name: 'mealType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'menuTrack': _i1.ParameterDescription(
              name: 'menuTrack',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i14.ExperienceEndpoint)
                  .createMenuEntry(
            session,
            menuDate: params['menuDate'],
            mealType: params['mealType'],
            title: params['title'],
            description: params['description'],
            menuTrack: params['menuTrack'],
          ),
        ),
        'updateMenuEntry': _i1.MethodConnector(
          name: 'updateMenuEntry',
          params: {
            'menuEntryId': _i1.ParameterDescription(
              name: 'menuEntryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'menuDate': _i1.ParameterDescription(
              name: 'menuDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'mealType': _i1.ParameterDescription(
              name: 'mealType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'menuTrack': _i1.ParameterDescription(
              name: 'menuTrack',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i14.ExperienceEndpoint)
                  .updateMenuEntry(
            session,
            menuEntryId: params['menuEntryId'],
            menuDate: params['menuDate'],
            mealType: params['mealType'],
            title: params['title'],
            description: params['description'],
            menuTrack: params['menuTrack'],
          ),
        ),
        'bulkUploadMonthlyMenu': _i1.MethodConnector(
          name: 'bulkUploadMonthlyMenu',
          params: {
            'year': _i1.ParameterDescription(
              name: 'year',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'month': _i1.ParameterDescription(
              name: 'month',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'menuTrack': _i1.ParameterDescription(
              name: 'menuTrack',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'entries': _i1.ParameterDescription(
              name: 'entries',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['experience'] as _i14.ExperienceEndpoint)
                  .bulkUploadMonthlyMenu(
            session,
            year: params['year'],
            month: params['month'],
            menuTrack: params['menuTrack'],
            entries: params['entries'],
          ),
        ),
      },
    );
    connectors['gallery'] = _i1.EndpointConnector(
      name: 'gallery',
      endpoint: endpoints['gallery']!,
      methodConnectors: {
        'listGalleries': _i1.MethodConnector(
          name: 'listGalleries',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gallery'] as _i15.GalleryEndpoint).listGalleries(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'getGallery': _i1.MethodConnector(
          name: 'getGallery',
          params: {
            'galleryId': _i1.ParameterDescription(
              name: 'galleryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gallery'] as _i15.GalleryEndpoint).getGallery(
            session,
            galleryId: params['galleryId'],
          ),
        ),
        'createGallery': _i1.MethodConnector(
          name: 'createGallery',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'audienceType': _i1.ParameterDescription(
              name: 'audienceType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'audienceClassroomId': _i1.ParameterDescription(
              name: 'audienceClassroomId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'audienceChildId': _i1.ParameterDescription(
              name: 'audienceChildId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gallery'] as _i15.GalleryEndpoint).createGallery(
            session,
            title: params['title'],
            description: params['description'],
            audienceType: params['audienceType'],
            audienceClassroomId: params['audienceClassroomId'],
            audienceChildId: params['audienceChildId'],
          ),
        ),
        'updateGallery': _i1.MethodConnector(
          name: 'updateGallery',
          params: {
            'galleryId': _i1.ParameterDescription(
              name: 'galleryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'audienceType': _i1.ParameterDescription(
              name: 'audienceType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'audienceClassroomId': _i1.ParameterDescription(
              name: 'audienceClassroomId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'audienceChildId': _i1.ParameterDescription(
              name: 'audienceChildId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'isPublished': _i1.ParameterDescription(
              name: 'isPublished',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gallery'] as _i15.GalleryEndpoint).updateGallery(
            session,
            galleryId: params['galleryId'],
            title: params['title'],
            description: params['description'],
            audienceType: params['audienceType'],
            audienceClassroomId: params['audienceClassroomId'],
            audienceChildId: params['audienceChildId'],
            isPublished: params['isPublished'],
          ),
        ),
        'addGalleryItem': _i1.MethodConnector(
          name: 'addGalleryItem',
          params: {
            'galleryId': _i1.ParameterDescription(
              name: 'galleryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'fileAssetId': _i1.ParameterDescription(
              name: 'fileAssetId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'caption': _i1.ParameterDescription(
              name: 'caption',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'sortOrder': _i1.ParameterDescription(
              name: 'sortOrder',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gallery'] as _i15.GalleryEndpoint).addGalleryItem(
            session,
            galleryId: params['galleryId'],
            fileAssetId: params['fileAssetId'],
            caption: params['caption'],
            sortOrder: params['sortOrder'],
          ),
        ),
        'listGalleryItems': _i1.MethodConnector(
          name: 'listGalleryItems',
          params: {
            'galleryId': _i1.ParameterDescription(
              name: 'galleryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['gallery'] as _i15.GalleryEndpoint).listGalleryItems(
            session,
            galleryId: params['galleryId'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
      },
    );
    connectors['habit'] = _i1.EndpointConnector(
      name: 'habit',
      endpoint: endpoints['habit']!,
      methodConnectors: {
        'listMealsByChild': _i1.MethodConnector(
          name: 'listMealsByChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint).listMealsByChild(
            session,
            childId: params['childId'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createMealEntry': _i1.MethodConnector(
          name: 'createMealEntry',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'mealType': _i1.ParameterDescription(
              name: 'mealType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'consumptionLevel': _i1.ParameterDescription(
              name: 'consumptionLevel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'recordedAt': _i1.ParameterDescription(
              name: 'recordedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'menuItems': _i1.ParameterDescription(
              name: 'menuItems',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint).createMealEntry(
            session,
            childId: params['childId'],
            mealType: params['mealType'],
            consumptionLevel: params['consumptionLevel'],
            recordedAt: params['recordedAt'],
            menuItems: params['menuItems'],
            notes: params['notes'],
          ),
        ),
        'updateMealEntry': _i1.MethodConnector(
          name: 'updateMealEntry',
          params: {
            'mealEntryId': _i1.ParameterDescription(
              name: 'mealEntryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'mealType': _i1.ParameterDescription(
              name: 'mealType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'consumptionLevel': _i1.ParameterDescription(
              name: 'consumptionLevel',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'recordedAt': _i1.ParameterDescription(
              name: 'recordedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'menuItems': _i1.ParameterDescription(
              name: 'menuItems',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint).updateMealEntry(
            session,
            mealEntryId: params['mealEntryId'],
            mealType: params['mealType'],
            consumptionLevel: params['consumptionLevel'],
            recordedAt: params['recordedAt'],
            menuItems: params['menuItems'],
            notes: params['notes'],
          ),
        ),
        'listNapsByChild': _i1.MethodConnector(
          name: 'listNapsByChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint).listNapsByChild(
            session,
            childId: params['childId'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createNapEntry': _i1.MethodConnector(
          name: 'createNapEntry',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'startedAt': _i1.ParameterDescription(
              name: 'startedAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endedAt': _i1.ParameterDescription(
              name: 'endedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'sleepQuality': _i1.ParameterDescription(
              name: 'sleepQuality',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint).createNapEntry(
            session,
            childId: params['childId'],
            startedAt: params['startedAt'],
            endedAt: params['endedAt'],
            durationMinutes: params['durationMinutes'],
            sleepQuality: params['sleepQuality'],
            notes: params['notes'],
          ),
        ),
        'updateNapEntry': _i1.MethodConnector(
          name: 'updateNapEntry',
          params: {
            'napEntryId': _i1.ParameterDescription(
              name: 'napEntryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'startedAt': _i1.ParameterDescription(
              name: 'startedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'endedAt': _i1.ParameterDescription(
              name: 'endedAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'durationMinutes': _i1.ParameterDescription(
              name: 'durationMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'sleepQuality': _i1.ParameterDescription(
              name: 'sleepQuality',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint).updateNapEntry(
            session,
            napEntryId: params['napEntryId'],
            startedAt: params['startedAt'],
            endedAt: params['endedAt'],
            durationMinutes: params['durationMinutes'],
            sleepQuality: params['sleepQuality'],
            notes: params['notes'],
          ),
        ),
        'listBowelMovementsByChild': _i1.MethodConnector(
          name: 'listBowelMovementsByChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint)
                  .listBowelMovementsByChild(
            session,
            childId: params['childId'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createBowelMovementEntry': _i1.MethodConnector(
          name: 'createBowelMovementEntry',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'eventAt': _i1.ParameterDescription(
              name: 'eventAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'consistency': _i1.ParameterDescription(
              name: 'consistency',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint)
                  .createBowelMovementEntry(
            session,
            childId: params['childId'],
            eventAt: params['eventAt'],
            eventType: params['eventType'],
            consistency: params['consistency'],
            notes: params['notes'],
          ),
        ),
        'updateBowelMovementEntry': _i1.MethodConnector(
          name: 'updateBowelMovementEntry',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'eventAt': _i1.ParameterDescription(
              name: 'eventAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'consistency': _i1.ParameterDescription(
              name: 'consistency',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint)
                  .updateBowelMovementEntry(
            session,
            entryId: params['entryId'],
            eventAt: params['eventAt'],
            eventType: params['eventType'],
            consistency: params['consistency'],
            notes: params['notes'],
          ),
        ),
        'getChildDailyHabits': _i1.MethodConnector(
          name: 'getChildDailyHabits',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'day': _i1.ParameterDescription(
              name: 'day',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['habit'] as _i16.HabitEndpoint).getChildDailyHabits(
            session,
            childId: params['childId'],
            day: params['day'],
          ),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'registerDeviceToken': _i1.MethodConnector(
          name: 'registerDeviceToken',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'platform': _i1.ParameterDescription(
              name: 'platform',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deviceId': _i1.ParameterDescription(
              name: 'deviceId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'deviceModel': _i1.ParameterDescription(
              name: 'deviceModel',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'appVersion': _i1.ParameterDescription(
              name: 'appVersion',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i17.NotificationEndpoint)
                  .registerDeviceToken(
            session,
            token: params['token'],
            platform: params['platform'],
            deviceId: params['deviceId'],
            deviceModel: params['deviceModel'],
            appVersion: params['appVersion'],
          ),
        ),
        'removeDeviceToken': _i1.MethodConnector(
          name: 'removeDeviceToken',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i17.NotificationEndpoint)
                  .removeDeviceToken(
            session,
            token: params['token'],
          ),
        ),
        'myNotifications': _i1.MethodConnector(
          name: 'myNotifications',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i17.NotificationEndpoint)
                  .myNotifications(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'markNotificationRead': _i1.MethodConnector(
          name: 'markNotificationRead',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i17.NotificationEndpoint)
                  .markNotificationRead(
            session,
            notificationId: params['notificationId'],
          ),
        ),
        'createSegmentedNotification': _i1.MethodConnector(
          name: 'createSegmentedNotification',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'category': _i1.ParameterDescription(
              name: 'category',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetScope': _i1.ParameterDescription(
              name: 'targetScope',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetClassroomId': _i1.ParameterDescription(
              name: 'targetClassroomId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'targetChildId': _i1.ParameterDescription(
              name: 'targetChildId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'targetUserId': _i1.ParameterDescription(
              name: 'targetUserId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i17.NotificationEndpoint)
                  .createSegmentedNotification(
            session,
            title: params['title'],
            body: params['body'],
            category: params['category'],
            targetScope: params['targetScope'],
            targetClassroomId: params['targetClassroomId'],
            targetChildId: params['targetChildId'],
            targetUserId: params['targetUserId'],
          ),
        ),
      },
    );
    connectors['organization'] = _i1.EndpointConnector(
      name: 'organization',
      endpoint: endpoints['organization']!,
      methodConnectors: {
        'listOrganizations': _i1.MethodConnector(
          name: 'listOrganizations',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['organization'] as _i18.OrganizationEndpoint)
                  .listOrganizations(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'getOrganization': _i1.MethodConnector(
          name: 'getOrganization',
          params: {
            'organizationId': _i1.ParameterDescription(
              name: 'organizationId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['organization'] as _i18.OrganizationEndpoint)
                  .getOrganization(
            session,
            organizationId: params['organizationId'],
          ),
        ),
        'createOrganization': _i1.MethodConnector(
          name: 'createOrganization',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'slug': _i1.ParameterDescription(
              name: 'slug',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'contactEmail': _i1.ParameterDescription(
              name: 'contactEmail',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['organization'] as _i18.OrganizationEndpoint)
                  .createOrganization(
            session,
            name: params['name'],
            slug: params['slug'],
            contactEmail: params['contactEmail'],
          ),
        ),
      },
    );
    connectors['pedagogicalReport'] = _i1.EndpointConnector(
      name: 'pedagogicalReport',
      endpoint: endpoints['pedagogicalReport']!,
      methodConnectors: {
        'listReportsByChild': _i1.MethodConnector(
          name: 'listReportsByChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pedagogicalReport'] as _i19.PedagogicalReportEndpoint)
                  .listReportsByChild(
            session,
            childId: params['childId'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'getReport': _i1.MethodConnector(
          name: 'getReport',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pedagogicalReport'] as _i19.PedagogicalReportEndpoint)
                  .getReport(
            session,
            reportId: params['reportId'],
          ),
        ),
        'createReport': _i1.MethodConnector(
          name: 'createReport',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'reportDate': _i1.ParameterDescription(
              name: 'reportDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'summary': _i1.ParameterDescription(
              name: 'summary',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'visibility': _i1.ParameterDescription(
              name: 'visibility',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pedagogicalReport'] as _i19.PedagogicalReportEndpoint)
                  .createReport(
            session,
            childId: params['childId'],
            reportDate: params['reportDate'],
            title: params['title'],
            summary: params['summary'],
            body: params['body'],
            status: params['status'],
            visibility: params['visibility'],
          ),
        ),
        'updateReport': _i1.MethodConnector(
          name: 'updateReport',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'reportDate': _i1.ParameterDescription(
              name: 'reportDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'summary': _i1.ParameterDescription(
              name: 'summary',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'visibility': _i1.ParameterDescription(
              name: 'visibility',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['pedagogicalReport'] as _i19.PedagogicalReportEndpoint)
                  .updateReport(
            session,
            reportId: params['reportId'],
            reportDate: params['reportDate'],
            title: params['title'],
            summary: params['summary'],
            body: params['body'],
            status: params['status'],
            visibility: params['visibility'],
          ),
        ),
      },
    );
    connectors['staff'] = _i1.EndpointConnector(
      name: 'staff',
      endpoint: endpoints['staff']!,
      methodConnectors: {
        'listStaff': _i1.MethodConnector(
          name: 'listStaff',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['staff'] as _i20.StaffEndpoint).listStaff(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'listGuardians': _i1.MethodConnector(
          name: 'listGuardians',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['staff'] as _i20.StaffEndpoint).listGuardians(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createStaffUser': _i1.MethodConnector(
          name: 'createStaffUser',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['staff'] as _i20.StaffEndpoint).createStaffUser(
            session,
            email: params['email'],
            password: params['password'],
            firstName: params['firstName'],
            lastName: params['lastName'],
            role: params['role'],
            phone: params['phone'],
          ),
        ),
        'updateStaffUser': _i1.MethodConnector(
          name: 'updateStaffUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'firstName': _i1.ParameterDescription(
              name: 'firstName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'lastName': _i1.ParameterDescription(
              name: 'lastName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['staff'] as _i20.StaffEndpoint).updateStaffUser(
            session,
            userId: params['userId'],
            firstName: params['firstName'],
            lastName: params['lastName'],
            phone: params['phone'],
            role: params['role'],
            isActive: params['isActive'],
          ),
        ),
        'assignClassroomPermission': _i1.MethodConnector(
          name: 'assignClassroomPermission',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'classroomId': _i1.ParameterDescription(
              name: 'classroomId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['staff'] as _i20.StaffEndpoint)
                  .assignClassroomPermission(
            session,
            userId: params['userId'],
            classroomId: params['classroomId'],
            role: params['role'],
          ),
        ),
        'removeClassroomPermission': _i1.MethodConnector(
          name: 'removeClassroomPermission',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'classroomId': _i1.ParameterDescription(
              name: 'classroomId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['staff'] as _i20.StaffEndpoint)
                  .removeClassroomPermission(
            session,
            userId: params['userId'],
            classroomId: params['classroomId'],
          ),
        ),
        'listStaffPermissions': _i1.MethodConnector(
          name: 'listStaffPermissions',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['staff'] as _i20.StaffEndpoint).listStaffPermissions(
            session,
            userId: params['userId'],
          ),
        ),
      },
    );
    connectors['tariff'] = _i1.EndpointConnector(
      name: 'tariff',
      endpoint: endpoints['tariff']!,
      methodConnectors: {
        'listTariffs': _i1.MethodConnector(
          name: 'listTariffs',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tariff'] as _i21.TariffEndpoint).listTariffs(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'createTariff': _i1.MethodConnector(
          name: 'createTariff',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'schedule': _i1.ParameterDescription(
              name: 'schedule',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'monthlyPrice': _i1.ParameterDescription(
              name: 'monthlyPrice',
              type: _i1.getType<double>(),
              nullable: false,
            ),
            'includesTransport': _i1.ParameterDescription(
              name: 'includesTransport',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tariff'] as _i21.TariffEndpoint).createTariff(
            session,
            name: params['name'],
            description: params['description'],
            schedule: params['schedule'],
            monthlyPrice: params['monthlyPrice'],
            includesTransport: params['includesTransport'],
          ),
        ),
        'updateTariff': _i1.MethodConnector(
          name: 'updateTariff',
          params: {
            'tariffId': _i1.ParameterDescription(
              name: 'tariffId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'schedule': _i1.ParameterDescription(
              name: 'schedule',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'monthlyPrice': _i1.ParameterDescription(
              name: 'monthlyPrice',
              type: _i1.getType<double?>(),
              nullable: true,
            ),
            'includesTransport': _i1.ParameterDescription(
              name: 'includesTransport',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'isActive': _i1.ParameterDescription(
              name: 'isActive',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tariff'] as _i21.TariffEndpoint).updateTariff(
            session,
            tariffId: params['tariffId'],
            name: params['name'],
            description: params['description'],
            schedule: params['schedule'],
            monthlyPrice: params['monthlyPrice'],
            includesTransport: params['includesTransport'],
            isActive: params['isActive'],
          ),
        ),
        'assignTariffToChild': _i1.MethodConnector(
          name: 'assignTariffToChild',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'tariffId': _i1.ParameterDescription(
              name: 'tariffId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'startDate': _i1.ParameterDescription(
              name: 'startDate',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endDate': _i1.ParameterDescription(
              name: 'endDate',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tariff'] as _i21.TariffEndpoint).assignTariffToChild(
            session,
            childId: params['childId'],
            tariffId: params['tariffId'],
            startDate: params['startDate'],
            endDate: params['endDate'],
            notes: params['notes'],
          ),
        ),
        'listChildTariffs': _i1.MethodConnector(
          name: 'listChildTariffs',
          params: {
            'childId': _i1.ParameterDescription(
              name: 'childId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['tariff'] as _i21.TariffEndpoint).listChildTariffs(
            session,
            childId: params['childId'],
          ),
        ),
      },
    );
    connectors['timeTracking'] = _i1.EndpointConnector(
      name: 'timeTracking',
      endpoint: endpoints['timeTracking']!,
      methodConnectors: {
        'checkIn': _i1.MethodConnector(
          name: 'checkIn',
          params: {
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['timeTracking'] as _i22.TimeTrackingEndpoint).checkIn(
            session,
            notes: params['notes'],
          ),
        ),
        'checkOut': _i1.MethodConnector(
          name: 'checkOut',
          params: {
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['timeTracking'] as _i22.TimeTrackingEndpoint).checkOut(
            session,
            notes: params['notes'],
          ),
        ),
        'myEntries': _i1.MethodConnector(
          name: 'myEntries',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['timeTracking'] as _i22.TimeTrackingEndpoint)
                  .myEntries(
            session,
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'listEntries': _i1.MethodConnector(
          name: 'listEntries',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'pageSize': _i1.ParameterDescription(
              name: 'pageSize',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['timeTracking'] as _i22.TimeTrackingEndpoint)
                  .listEntries(
            session,
            userId: params['userId'],
            from: params['from'],
            to: params['to'],
            page: params['page'],
            pageSize: params['pageSize'],
          ),
        ),
        'getEntry': _i1.MethodConnector(
          name: 'getEntry',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['timeTracking'] as _i22.TimeTrackingEndpoint).getEntry(
            session,
            entryId: params['entryId'],
          ),
        ),
        'correctEntry': _i1.MethodConnector(
          name: 'correctEntry',
          params: {
            'targetEntryId': _i1.ParameterDescription(
              name: 'targetEntryId',
              type: _i1.getType<_i23.UuidValue>(),
              nullable: false,
            ),
            'correctedEntryType': _i1.ParameterDescription(
              name: 'correctedEntryType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'correctionReason': _i1.ParameterDescription(
              name: 'correctionReason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['timeTracking'] as _i22.TimeTrackingEndpoint)
                  .correctEntry(
            session,
            targetEntryId: params['targetEntryId'],
            correctedEntryType: params['correctedEntryType'],
            correctionReason: params['correctionReason'],
            notes: params['notes'],
          ),
        ),
        'exportTimeEntries': _i1.MethodConnector(
          name: 'exportTimeEntries',
          params: {
            'from': _i1.ParameterDescription(
              name: 'from',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'to': _i1.ParameterDescription(
              name: 'to',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<_i23.UuidValue?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['timeTracking'] as _i22.TimeTrackingEndpoint)
                  .exportTimeEntries(
            session,
            from: params['from'],
            to: params['to'],
            userId: params['userId'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i24.Endpoints()..initializeEndpoints(server);
  }
}
