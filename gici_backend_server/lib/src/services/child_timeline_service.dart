import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

class ChildTimelineService {
  const ChildTimelineService();

  Future<List<ChildTimelineItem>> buildTimeline(
    Session session, {
    required int organizationId,
    required int childId,
    required int limit,
    required int offset,
  }) async {
    final mealsFuture = MealEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.recordedAt,
      orderDescending: true,
      limit: 200,
    );

    final napsFuture = NapEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.startedAt,
      orderDescending: true,
      limit: 200,
    );

    final bowelFuture = BowelMovementEntry.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) & t.childId.equals(childId),
      orderBy: (t) => t.eventAt,
      orderDescending: true,
      limit: 200,
    );

    final reportsFuture = PedagogicalReport.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.childId.equals(childId) &
          t.deletedAt.equals(null),
      orderBy: (t) => t.reportDate,
      orderDescending: true,
      limit: 200,
    );

    final documentsFuture = ChildDocument.db.find(
      session,
      where: (t) =>
          t.organizationId.equals(organizationId) &
          t.childId.equals(childId) &
          t.deletedAt.equals(null),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 200,
    );

    final meals = await mealsFuture;
    final naps = await napsFuture;
    final bowelMovements = await bowelFuture;
    final reports = await reportsFuture;
    final documents = await documentsFuture;

    final items = <ChildTimelineItem>[
      ...meals.map(
        (m) => ChildTimelineItem(
          childId: childId,
          eventAt: m.recordedAt,
          eventType: 'meal',
          title: 'Meal: ${m.mealType}',
          description: 'Consumption: ${m.consumptionLevel}${m.notes == null ? '' : ' · ${m.notes}'}',
          referenceType: 'meal_entry',
          referenceId: m.id,
        ),
      ),
      ...naps.map(
        (n) => ChildTimelineItem(
          childId: childId,
          eventAt: n.startedAt,
          eventType: 'nap',
          title: 'Nap',
          description:
              'Start: ${n.startedAt.toIso8601String()}${n.endedAt == null ? '' : ' · End: ${n.endedAt!.toIso8601String()}'}${n.notes == null ? '' : ' · ${n.notes}'}',
          referenceType: 'nap_entry',
          referenceId: n.id,
        ),
      ),
      ...bowelMovements.map(
        (b) => ChildTimelineItem(
          childId: childId,
          eventAt: b.eventAt,
          eventType: 'bowel_movement',
          title: 'Bowel / diaper event',
          description:
              '${b.eventType}${b.consistency == null ? '' : ' · ${b.consistency}'}${b.notes == null ? '' : ' · ${b.notes}'}',
          referenceType: 'bowel_movement_entry',
          referenceId: b.id,
        ),
      ),
      ...reports.map(
        (r) => ChildTimelineItem(
          childId: childId,
          eventAt: r.reportDate,
          eventType: 'pedagogical_report',
          title: r.title,
          description: r.summary,
          referenceType: 'pedagogical_report',
          referenceId: r.id,
        ),
      ),
      ...documents.map(
        (d) => ChildTimelineItem(
          childId: childId,
          eventAt: d.createdAt,
          eventType: 'child_document',
          title: 'Document added: ${d.title}',
          description: d.description,
          referenceType: 'child_document',
          referenceId: d.id,
        ),
      ),
    ];

    items.sort((a, b) => b.eventAt.compareTo(a.eventAt));
    final safeOffset = offset.clamp(0, items.length);
    final safeEnd = (safeOffset + limit).clamp(0, items.length);
    return items.sublist(safeOffset, safeEnd);
  }
}
