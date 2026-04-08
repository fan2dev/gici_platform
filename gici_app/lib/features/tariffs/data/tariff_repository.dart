import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class TariffRepository {
  const TariffRepository(this._client);

  final Client _client;

  Future<List<Tariff>> listTariffs({
    int page = 0,
    int pageSize = 50,
  }) {
    return _client.tariff.listTariffs(
      page: page,
      pageSize: pageSize,
    );
  }

  Future<Tariff> createTariff({
    required String name,
    String? description,
    required String schedule,
    required double monthlyPrice,
    bool includesTransport = false,
  }) {
    return _client.tariff.createTariff(
      name: name,
      description: description,
      schedule: schedule,
      monthlyPrice: monthlyPrice,
      includesTransport: includesTransport,
    );
  }

  Future<Tariff> updateTariff({
    required UuidValue tariffId,
    String? name,
    String? description,
    String? schedule,
    double? monthlyPrice,
    bool? includesTransport,
  }) {
    return _client.tariff.updateTariff(
      tariffId: tariffId,
      name: name,
      description: description,
      schedule: schedule,
      monthlyPrice: monthlyPrice,
      includesTransport: includesTransport,
    );
  }

  Future<ChildTariffAssignment> assignTariffToChild({
    required UuidValue tariffId,
    required UuidValue childId,
    required DateTime startDate,
    DateTime? endDate,
    String? notes,
  }) {
    return _client.tariff.assignTariffToChild(
      tariffId: tariffId,
      childId: childId,
      startDate: startDate,
      endDate: endDate,
      notes: notes,
    );
  }

  Future<List<ChildTariffAssignment>> listChildTariffs({
    required UuidValue childId,
  }) {
    return _client.tariff.listChildTariffs(
      childId: childId,
    );
  }
}
