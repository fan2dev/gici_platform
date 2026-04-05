import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class PedagogicalReportRepository {
  const PedagogicalReportRepository(this._client);

  final Client _client;

  Future<List<PedagogicalReport>> listReportsByChild({
    required UuidValue childId,
    int page = 0,
    int pageSize = 30,
  }) {
    return _client.pedagogicalReport.listReportsByChild(
      childId: childId,
      page: page,
      pageSize: pageSize,
    );
  }

  Future<PedagogicalReport> getReport({
    required UuidValue reportId,
  }) {
    return _client.pedagogicalReport.getReport(
      reportId: reportId,
    );
  }

  Future<PedagogicalReport> createReport({
    required UuidValue childId,
    required DateTime reportDate,
    required String title,
    required String summary,
    required String body,
    String status = 'published',
    String visibility = 'guardian',
  }) {
    return _client.pedagogicalReport.createReport(
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
    required UuidValue reportId,
    DateTime? reportDate,
    String? title,
    String? summary,
    String? body,
    String? status,
    String? visibility,
  }) {
    return _client.pedagogicalReport.updateReport(
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
