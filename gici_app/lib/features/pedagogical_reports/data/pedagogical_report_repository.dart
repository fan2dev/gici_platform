import 'package:gici_backend_client/gici_backend_server_client.dart';

class PedagogicalReportRepository {
  const PedagogicalReportRepository(this._client);

  final Client _client;

  Future<List<PedagogicalReport>> listReportsByChild({
    required String organizationId,
    required String actorId,
    required int childId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.pedagogicalReport.listReportsByChild(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<PedagogicalReport> getReport({
    required String organizationId,
    required String actorId,
    required int reportId,
  }) {
    return _client.pedagogicalReport.getReport(
      organizationId: organizationId,
      actorId: actorId,
      reportId: reportId,
    );
  }

  Future<PedagogicalReport> createReport({
    required String organizationId,
    required String actorId,
    required int childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    String status = 'published',
    String visibility = 'guardian',
  }) {
    return _client.pedagogicalReport.createReport(
      organizationId: organizationId,
      actorId: actorId,
      childId: childId,
      reportDate: reportDate,
      title: title,
      summary: summary,
      body: body,
      status: status,
      visibility: visibility,
    );
  }

  Future<PedagogicalReport> updateReport({
    required String organizationId,
    required String actorId,
    required int reportId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
  }) {
    return _client.pedagogicalReport.updateReport(
      organizationId: organizationId,
      actorId: actorId,
      reportId: reportId,
      reportDate: reportDate,
      title: title,
      summary: summary,
      body: body,
      status: status,
      visibility: visibility,
    );
  }
}
