import 'package:get_it/get_it.dart';
import 'package:gici_backend_client/gici_backend_server_client.dart';

import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/data/auth_session_storage.dart';
import '../../features/chat/data/chat_repository.dart';
import '../../features/children/data/child_repository.dart';
import '../../features/child_timeline/data/child_timeline_repository.dart';
import '../../features/classrooms/data/classroom_repository.dart';
import '../../features/data_change_requests/data/data_change_request_repository.dart';
import '../../features/documents/data/document_repository.dart';
import '../../features/experience/data/experience_repository.dart';
import '../../features/galleries/data/gallery_repository.dart';
import '../../features/habits/data/habit_repository.dart';
import '../../features/notifications/data/notification_repository.dart';
import '../../features/pedagogical_reports/data/pedagogical_report_repository.dart';
import '../../features/time_tracking/data/time_tracking_repository.dart';
import '../network/backend_client.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  if (!sl.isRegistered<DateTime Function()>()) {
    sl.registerLazySingleton<DateTime Function()>(() => DateTime.now);
  }

  if (!sl.isRegistered<Client>()) {
    sl.registerLazySingleton<Client>(() => BackendClientProvider.instance);
  }

  if (!sl.isRegistered<AuthRepository>()) {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<AuthSessionStorage>()) {
    sl.registerLazySingleton<AuthSessionStorage>(
      () => const AuthSessionStorage(),
    );
  }

  if (!sl.isRegistered<ChatRepository>()) {
    sl.registerLazySingleton<ChatRepository>(
      () => ChatRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<ChildRepository>()) {
    sl.registerLazySingleton<ChildRepository>(
      () => ChildRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<ClassroomRepository>()) {
    sl.registerLazySingleton<ClassroomRepository>(
      () => ClassroomRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<TimeTrackingRepository>()) {
    sl.registerLazySingleton<TimeTrackingRepository>(
      () => TimeTrackingRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<DocumentRepository>()) {
    sl.registerLazySingleton<DocumentRepository>(
      () => DocumentRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<GalleryRepository>()) {
    sl.registerLazySingleton<GalleryRepository>(
      () => GalleryRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<NotificationRepository>()) {
    sl.registerLazySingleton<NotificationRepository>(
      () => NotificationRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<ExperienceRepository>()) {
    sl.registerLazySingleton<ExperienceRepository>(
      () => ExperienceRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<HabitRepository>()) {
    sl.registerLazySingleton<HabitRepository>(
      () => HabitRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<ChildTimelineRepository>()) {
    sl.registerLazySingleton<ChildTimelineRepository>(
      () => ChildTimelineRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<PedagogicalReportRepository>()) {
    sl.registerLazySingleton<PedagogicalReportRepository>(
      () => PedagogicalReportRepository(sl<Client>()),
    );
  }

  if (!sl.isRegistered<DataChangeRequestRepository>()) {
    sl.registerLazySingleton<DataChangeRequestRepository>(
      () => DataChangeRequestRepository(sl<Client>()),
    );
  }
}
