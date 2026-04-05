import 'package:serverpod/serverpod.dart';

import '../services/bootstrap_seed_service.dart';

class BootstrapEndpoint extends Endpoint {
  BootstrapEndpoint();

  final _seedService = const BootstrapSeedService();

  Future<String> seedDemoData(
    Session session, {
    required String bootstrapKey,
  }) async {
    if (bootstrapKey != 'local-dev-bootstrap') {
      throw Exception('Invalid bootstrap key.');
    }

    await _seedService.seedElBorreguet(session);
    return 'Seed completed for El Borreguet.';
  }
}
