import 'package:gici_backend_client/gici_backend_server_client.dart';
import 'package:uuid/uuid_value.dart';

class ConsentRepository {
  const ConsentRepository(this._client);

  final Client _client;

  Future<List<ConsentRecord>> getMyConsents() {
    return _client.consent.getMyConsents();
  }

  Future<ConsentRecord> acceptConsent({
    required String consentType,
    UuidValue? childId,
  }) {
    return _client.consent.acceptConsent(
      consentType: consentType,
      childId: childId,
    );
  }

  Future<ConsentRecord> revokeConsent({
    required String consentType,
    UuidValue? childId,
  }) {
    return _client.consent.revokeConsent(
      consentType: consentType,
      childId: childId,
    );
  }
}
