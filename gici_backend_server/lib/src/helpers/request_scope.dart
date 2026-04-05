class RequestScope {
  const RequestScope({
    required this.organizationId,
    required this.actorRole,
    required this.actorId,
  });

  final int organizationId;
  final String actorRole;
  final int actorId;
}

int parseId(String value, String fieldName) {
  final parsed = int.tryParse(value);
  if (parsed == null) {
    throw ArgumentError.value(value, fieldName, 'Must be a valid integer id');
  }
  return parsed;
}

int parseOrganizationId(String organizationId) {
  return parseId(organizationId, 'organizationId');
}

int parseActorId(String actorId) {
  return parseId(actorId, 'actorId');
}

void requireRole(String actorRole, List<String> allowedRoles) {
  if (!allowedRoles.contains(actorRole)) {
    throw Exception('Role $actorRole is not allowed for this action.');
  }
}
