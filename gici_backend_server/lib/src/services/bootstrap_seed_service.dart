import 'package:bcrypt/bcrypt.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;

import '../generated/protocol.dart';

class BootstrapSeedService {
  const BootstrapSeedService();

  static String _hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  Future<AppUser> _createUserWithAuth(
    Session session, {
    required AppUser appUser,
    required DateTime now,
  }) async {
    final inserted = await AppUser.db.insertRow(session, appUser);
    final userInfo = auth.UserInfo(
      userIdentifier: appUser.email,
      email: appUser.email,
      userName: '${appUser.firstName} ${appUser.lastName}',
      created: now,
      scopeNames: [],
      blocked: false,
    );
    final created = await auth.Users.createUser(session, userInfo, 'email');
    if (created != null) {
      final linked = inserted.copyWith(serverpodUserId: created.id!);
      await AppUser.db.updateRow(session, linked);
      return linked;
    }
    return inserted;
  }

  Future<void> seedElBorreguet(Session session) async {
    final now = DateTime.now().toUtc();

    // Check if already seeded
    var organization = await Organization.db.findFirstRow(
      session,
      where: (t) => t.slug.equals('el-borreguet') & t.deletedAt.equals(null),
    );
    if (organization != null) {
      // Check if we need to add the alejandrofan2 user
      final existingFan = await AppUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals('alejandrofan2@gmail.com'),
      );
      if (existingFan == null) {
        await _createUserWithAuth(
          session,
          now: now,
          appUser: AppUser(
            organizationId: organization.id!,
            email: 'alejandrofan2@gmail.com',
            passwordHash: _hashPassword('Gici2026!Adm'),
            firstName: 'Alejandro',
            lastName: 'Fan',
            phone: null,
            role: 'organization_admin',
            isActive: true,
            emailVerified: true,
            phoneVerified: false,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
      return; // Already seeded
    }

    // =========================================================
    // 1. ORGANIZATION
    // =========================================================
    organization = await Organization.db.insertRow(
      session,
      Organization(
        name: 'El Borreguet',
        legalName: 'El Borreguet Escola Infantil S.L.',
        slug: 'el-borreguet',
        contactEmail: 'info@elborreguet.com',
        contactPhone: '+34 961 234 567',
        address: 'Carrer de la Llum, 15',
        city: 'Valencia',
        postalCode: '46006',
        country: 'ES',
        taxId: 'B98765432',
        status: 'active',
        createdAt: now,
        updatedAt: now,
      ),
    );
    final orgId = organization.id!;

    // =========================================================
    // 2. ORGANIZATION BRANDING & SETTINGS
    // =========================================================
    await OrganizationBranding.db.insertRow(
      session,
      OrganizationBranding(
        organizationId: orgId,
        primaryColor: '#4CAF50',
        secondaryColor: '#FFC107',
        createdAt: now,
        updatedAt: now,
      ),
    );

    await OrganizationSettings.db.insertRow(
      session,
      OrganizationSettings(
        organizationId: orgId,
        defaultLanguage: 'es',
        timezone: 'Europe/Madrid',
        dateFormat: 'dd/MM/yyyy',
        timeFormat: 'HH:mm',
        workingHoursStart: '07:30',
        workingHoursEnd: '17:00',
        maxChildrenPerClassroom: 20,
        earlyCheckInMinutes: 15,
        lateCheckOutMinutes: 30,
        guardianPhotoUploadEnabled: true,
        chatEnabled: true,
        pushNotificationsEnabled: true,
        requireGuardianUploadApproval: false,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // =========================================================
    // 3. CLASSROOMS (5)
    // =========================================================
    final classroomData = [
      ('Pollets', 'Aula bebés 0-1 año', 0, 1, 8, '#E91E63'),
      ('Ànecs', 'Aula 1-2 años', 1, 2, 12, '#2196F3'),
      ('Ovelles', 'Aula 2-3 años', 2, 3, 16, '#4CAF50'),
      ('Cavalls', 'Aula 2-3 años grupo B', 2, 3, 14, '#FF9800'),
      ('Estrelles', 'Aula adaptación', 0, 3, 10, '#9C27B0'),
    ];

    final classrooms = <Classroom>[];
    for (final (name, desc, min, max, cap, color) in classroomData) {
      final c = await Classroom.db.insertRow(
        session,
        Classroom(
          organizationId: orgId,
          name: name,
          description: desc,
          ageGroupMin: min,
          ageGroupMax: max,
          capacity: cap,
          color: color,
          status: 'active',
          createdAt: now,
          updatedAt: now,
        ),
      );
      classrooms.add(c);
    }

    // =========================================================
    // 4. USERS — Your admin account
    // =========================================================
    final alejandro = await _createUserWithAuth(
      session,
      now: now,
      appUser: AppUser(
        organizationId: orgId,
        email: 'alejandrofan2@gmail.com',
        passwordHash: _hashPassword('Gici2026!Adm'),
        firstName: 'Alejandro',
        lastName: 'Fan',
        phone: null,
        role: 'organization_admin',
        isActive: true,
        emailVerified: true,
        phoneVerified: false,
        createdAt: now,
        updatedAt: now,
      ),
    );

    // =========================================================
    // 5. USERS — Staff (4)
    // =========================================================
    final staffData = [
      ('Laura', 'Ribas', 'laura@elborreguet.com', 'organization_admin'),
      ('Marc', 'Serra', 'marc@elborreguet.com', 'staff'),
      ('Nuria', 'Vidal', 'nuria@elborreguet.com', 'staff'),
      ('Carla', 'Puig', 'carla@elborreguet.com', 'staff'),
    ];

    final staffUsers = <AppUser>[];
    for (final (first, last, email, role) in staffData) {
      final u = await _createUserWithAuth(
        session,
        now: now,
        appUser: AppUser(
          organizationId: orgId,
          email: email,
          passwordHash: _hashPassword('Staff123!'),
          firstName: first,
          lastName: last,
          phone: null,
          role: role,
          isActive: true,
          emailVerified: true,
          phoneVerified: false,
          createdAt: now,
          updatedAt: now,
        ),
      );
      staffUsers.add(u);
    }

    // =========================================================
    // 6. USERS — Guardians (8)
    // =========================================================
    final guardianData = [
      ('Ana', 'Martínez', 'ana.martinez@demo.com'),
      ('Jordi', 'Soler', 'jordi.soler@demo.com'),
      ('María', 'García', 'maria.garcia@demo.com'),
      ('Pedro', 'López', 'pedro.lopez@demo.com'),
      ('Elena', 'Fernández', 'elena.fernandez@demo.com'),
      ('David', 'Ruiz', 'david.ruiz@demo.com'),
      ('Sara', 'Navarro', 'sara.navarro@demo.com'),
      ('Carlos', 'Moreno', 'carlos.moreno@demo.com'),
    ];

    final guardians = <AppUser>[];
    for (final (first, last, email) in guardianData) {
      final u = await _createUserWithAuth(
        session,
        now: now,
        appUser: AppUser(
          organizationId: orgId,
          email: email,
          passwordHash: _hashPassword('Family123!'),
          firstName: first,
          lastName: last,
          phone: null,
          role: 'guardian',
          isActive: true,
          emailVerified: true,
          phoneVerified: false,
          createdAt: now,
          updatedAt: now,
        ),
      );
      guardians.add(u);
    }

    // =========================================================
    // 7. CHILDREN (12)
    // =========================================================
    final childData = [
      ('Leo', 'Martínez', '2024-03-15', 'male', null, null),
      ('Mia', 'Soler', '2023-09-02', 'female', null, 'Intolerancia lactosa'),
      ('Hugo', 'García', '2024-01-20', 'male', 'Asma leve', null),
      ('Lucía', 'López', '2023-06-11', 'female', null, null),
      ('Pol', 'Fernández', '2024-07-08', 'male', null, 'Alergia al huevo'),
      ('Emma', 'Ruiz', '2023-11-25', 'female', null, null),
      ('Pau', 'Navarro', '2024-05-30', 'male', null, null),
      ('Olivia', 'Moreno', '2023-04-18', 'female', 'Dermatitis atópica', null),
      ('Martí', 'Martínez', '2025-01-10', 'male', null, null),
      ('Noa', 'García', '2024-09-05', 'female', null, null),
      ('Jan', 'Soler', '2025-02-14', 'male', null, null),
      ('Laia', 'López', '2024-11-22', 'female', null, 'Alergia frutos secos'),
    ];

    final children = <Child>[];
    for (final (first, last, dob, gender, medical, allergies) in childData) {
      final c = await Child.db.insertRow(
        session,
        Child(
          organizationId: orgId,
          firstName: first,
          lastName: last,
          dateOfBirth: DateTime.parse(dob),
          gender: gender,
          medicalNotes: medical,
          allergies: allergies,
          enrollmentDate: now,
          status: 'active',
          createdAt: now,
          updatedAt: now,
        ),
      );
      children.add(c);
    }

    // =========================================================
    // 8. CLASSROOM ASSIGNMENTS
    // =========================================================
    // Pollets (0-1): Martí, Jan
    // Ànecs (1-2): Leo, Pol, Pau, Noa
    // Ovelles (2-3): Mia, Lucía, Emma, Olivia
    // Cavalls (2-3B): Hugo, Laia
    final assignments = <(int, int)>[
      (0, 8), (0, 10), // Pollets
      (1, 0), (1, 4), (1, 6), (1, 9), // Ànecs
      (2, 1), (2, 3), (2, 5), (2, 7), // Ovelles
      (3, 2), (3, 11), // Cavalls
    ];

    for (final (ci, chi) in assignments) {
      await ClassroomAssignment.db.insertRow(
        session,
        ClassroomAssignment(
          organizationId: orgId,
          classroomId: classrooms[ci].id!,
          childId: children[chi].id!,
          assignedAt: now,
          assignedByUserId: alejandro.id!,
          status: 'active',
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // =========================================================
    // 9. GUARDIAN-CHILD RELATIONS
    // =========================================================
    // Each guardian pair linked to 1-2 children
    final relations = <(int, int, String, bool)>[
      (0, 0, 'madre', true),  // Ana → Leo
      (0, 8, 'madre', true),  // Ana → Martí
      (1, 1, 'padre', true),  // Jordi → Mia
      (1, 10, 'padre', true), // Jordi → Jan
      (2, 2, 'madre', true),  // María → Hugo
      (2, 9, 'madre', true),  // María → Noa
      (3, 3, 'padre', true),  // Pedro → Lucía
      (3, 11, 'padre', true), // Pedro → Laia
      (4, 4, 'madre', true),  // Elena → Pol
      (5, 5, 'padre', true),  // David → Emma
      (6, 6, 'madre', true),  // Sara → Pau
      (7, 7, 'padre', true),  // Carlos → Olivia
    ];

    for (final (gi, chi, rel, primary) in relations) {
      await ChildGuardianRelation.db.insertRow(
        session,
        ChildGuardianRelation(
          organizationId: orgId,
          childId: children[chi].id!,
          guardianUserId: guardians[gi].id!,
          relation: rel,
          isPrimary: primary,
          canPickup: true,
          canViewReports: true,
          canViewPhotos: true,
          emergencyContactOrder: 1,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // =========================================================
    // 10. TIME ENTRIES (last 5 days for staff)
    // =========================================================
    for (var dayOffset = 0; dayOffset < 5; dayOffset++) {
      final day = now.subtract(Duration(days: dayOffset));
      final checkIn = DateTime.utc(day.year, day.month, day.day, 7, 30 + (dayOffset % 3) * 5);
      final checkOut = DateTime.utc(day.year, day.month, day.day, 16, 45 + (dayOffset % 4) * 5);

      for (final staff in staffUsers.where((u) => u.role == 'staff')) {
        await TimeEntry.db.insert(session, [
          TimeEntry(
            organizationId: orgId,
            userId: staff.id!,
            entryType: 'check_in',
            recordedAt: checkIn,
            isManualEntry: false,
            createdByUserId: staff.id!,
            createdAt: checkIn,
          ),
          TimeEntry(
            organizationId: orgId,
            userId: staff.id!,
            entryType: 'check_out',
            recordedAt: checkOut,
            isManualEntry: false,
            createdByUserId: staff.id!,
            createdAt: checkOut,
          ),
        ]);
      }
    }

    // =========================================================
    // 11. MEAL ENTRIES (today for several children)
    // =========================================================
    final today = DateTime.utc(now.year, now.month, now.day);
    final mealStaff = staffUsers.firstWhere((u) => u.role == 'staff');

    for (var i = 0; i < 8; i++) {
      await MealEntry.db.insertRow(
        session,
        MealEntry(
          organizationId: orgId,
          childId: children[i].id!,
          recordedByUserId: mealStaff.id!,
          mealType: 'lunch',
          consumptionLevel: ['all', 'most', 'half', 'most'][i % 4],
          recordedAt: today.add(const Duration(hours: 12, minutes: 30)),
          notes: i % 3 == 0 ? 'Ha comido muy bien' : null,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // =========================================================
    // 12. NAP ENTRIES (today)
    // =========================================================
    for (var i = 0; i < 6; i++) {
      await NapEntry.db.insertRow(
        session,
        NapEntry(
          organizationId: orgId,
          childId: children[i].id!,
          recordedByUserId: mealStaff.id!,
          startedAt: today.add(const Duration(hours: 13, minutes: 15)),
          endedAt: today.add(Duration(hours: 14, minutes: 30 + (i * 5))),
          durationMinutes: 75 + (i * 5),
          sleepQuality: ['good', 'good', 'restless', 'good', 'regular', 'good'][i],
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // =========================================================
    // 13. BOWEL MOVEMENT ENTRIES (today)
    // =========================================================
    for (var i = 0; i < 5; i++) {
      await BowelMovementEntry.db.insertRow(
        session,
        BowelMovementEntry(
          organizationId: orgId,
          childId: children[i].id!,
          recordedByUserId: mealStaff.id!,
          eventAt: today.add(Duration(hours: 10, minutes: i * 20)),
          eventType: i % 2 == 0 ? 'diaper_change' : 'toilet',
          consistency: 'normal',
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // =========================================================
    // 14. MENU ENTRIES (this week) — normal track
    // =========================================================
    final menuItems = [
      ('Puré de verduras con pollo', 'Arroz con tomate y tortilla francesa', 'Fruta de temporada'),
      ('Crema de calabaza', 'Pasta con atún y ensalada', 'Yogur natural'),
      ('Lentejas con verduras', 'Merluza al horno con patata', 'Fruta de temporada'),
      ('Sopa de fideos', 'Pollo al horno con guisantes', 'Natillas caseras'),
      ('Crema de zanahoria', 'Albóndigas con arroz', 'Fruta de temporada'),
    ];

    for (var d = 0; d < 5; d++) {
      final menuDate = today.subtract(Duration(days: today.weekday - 1 - d));
      final (first, second, dessert) = menuItems[d];
      await MenuEntry.db.insert(session, [
        MenuEntry(
          organizationId: orgId,
          menuDate: menuDate,
          menuTrack: 'normal',
          mealType: 'lunch_first',
          title: first,
          createdByUserId: alejandro.id!,
          createdAt: now,
          updatedAt: now,
        ),
        MenuEntry(
          organizationId: orgId,
          menuDate: menuDate,
          menuTrack: 'normal',
          mealType: 'lunch_second',
          title: second,
          createdByUserId: alejandro.id!,
          createdAt: now,
          updatedAt: now,
        ),
        MenuEntry(
          organizationId: orgId,
          menuDate: menuDate,
          menuTrack: 'normal',
          mealType: 'dessert',
          title: dessert,
          createdByUserId: alejandro.id!,
          createdAt: now,
          updatedAt: now,
        ),
      ]);
    }

    // =========================================================
    // 14b. MENU ENTRIES (this week) — menu2 track (triturado)
    // =========================================================
    final menu2Items = [
      ('Puré suave de verduras con pollo triturado', 'Arroz pasado con tomate natural', 'Compota de manzana'),
      ('Crema fina de calabaza', 'Pasta muy cocida con atún triturado', 'Yogur natural sin trozos'),
      ('Puré de lentejas con verduras', 'Merluza triturada con patata', 'Compota de pera'),
      ('Caldo con fideos finos', 'Pollo triturado con guisantes', 'Natillas suaves'),
      ('Crema de zanahoria fina', 'Albóndigas trituradas con arroz', 'Compota de frutas'),
    ];

    for (var d = 0; d < 5; d++) {
      final menuDate = today.subtract(Duration(days: today.weekday - 1 - d));
      final (first, second, dessert) = menu2Items[d];
      await MenuEntry.db.insert(session, [
        MenuEntry(
          organizationId: orgId,
          menuDate: menuDate,
          menuTrack: 'menu2',
          mealType: 'lunch_first',
          title: first,
          createdByUserId: alejandro.id!,
          createdAt: now,
          updatedAt: now,
        ),
        MenuEntry(
          organizationId: orgId,
          menuDate: menuDate,
          menuTrack: 'menu2',
          mealType: 'lunch_second',
          title: second,
          createdByUserId: alejandro.id!,
          createdAt: now,
          updatedAt: now,
        ),
        MenuEntry(
          organizationId: orgId,
          menuDate: menuDate,
          menuTrack: 'menu2',
          mealType: 'dessert',
          title: dessert,
          createdByUserId: alejandro.id!,
          createdAt: now,
          updatedAt: now,
        ),
      ]);
    }

    // =========================================================
    // 15. PEDAGOGICAL REPORTS (2)
    // =========================================================
    await PedagogicalReport.db.insert(session, [
      PedagogicalReport(
        organizationId: orgId,
        childId: children[0].id!, // Leo
        reportDate: now.subtract(const Duration(days: 7)),
        title: 'Informe trimestral - Leo',
        summary: 'Leo ha mostrado un gran avance en su desarrollo motor y social.',
        body: 'Durante este trimestre, Leo ha progresado significativamente en la motricidad fina. '
            'Muestra interés por los juegos de construcción y participa activamente en las actividades grupales. '
            'Su relación con los compañeros es muy positiva y colaborativa.',
        status: 'published',
        visibility: 'guardian',
        createdByUserId: staffUsers[1].id!, // Marc
        createdAt: now,
        updatedAt: now,
      ),
      PedagogicalReport(
        organizationId: orgId,
        childId: children[1].id!, // Mia
        reportDate: now.subtract(const Duration(days: 3)),
        title: 'Seguimiento mensual - Mia',
        summary: 'Mia continúa con buen rendimiento en todas las áreas.',
        body: 'Mia demuestra una excelente capacidad comunicativa para su edad. '
            'Ha comenzado a formar frases más complejas y muestra curiosidad por los libros. '
            'Se recomienda continuar con la lectura diaria en casa.',
        status: 'published',
        visibility: 'guardian',
        createdByUserId: staffUsers[2].id!, // Nuria
        createdAt: now,
        updatedAt: now,
      ),
    ]);

    // =========================================================
    // 16. NOTIFICATIONS (5 recent)
    // =========================================================
    final notifData = [
      ('Reunión de padres', 'La reunión trimestral será el próximo viernes a las 17:00.', 'all'),
      ('Excursión al parque', 'El miércoles iremos al parque municipal. Traed ropa cómoda.', 'all'),
      ('Menú actualizado', 'Se ha actualizado el menú semanal con nuevas opciones.', 'all'),
      ('Fotos nuevas', 'Se han subido nuevas fotos de la actividad de pintura.', 'all'),
      ('Recordatorio vacunas', 'Recordad traer el carnet de vacunas actualizado.', 'all'),
    ];

    for (var i = 0; i < notifData.length; i++) {
      final (title, body, scope) = notifData[i];
      // Send to all guardians
      for (final guardian in guardians) {
        await NotificationRecord.db.insertRow(
          session,
          NotificationRecord(
            organizationId: orgId,
            userId: guardian.id!,
            title: title,
            body: body,
            category: 'general',
            targetScope: scope,
            createdByUserId: alejandro.id!,
            isRead: i > 2, // First 3 unread
            createdAt: now.subtract(Duration(hours: i * 12)),
          ),
        );
      }
    }

    // =========================================================
    // 17. CHAT CONVERSATIONS — One child_group per child
    // =========================================================
    // Build a map of childIndex → list of guardian users
    final childGuardianMap = <int, List<AppUser>>{};
    for (final (gi, chi, _, _) in relations) {
      childGuardianMap.putIfAbsent(chi, () => []);
      childGuardianMap[chi]!.add(guardians[gi]);
    }

    // Build a map of childIndex → classroom index (for staff assignment)
    final childClassroomMap = <int, int>{};
    for (final (ci, chi) in assignments) {
      childClassroomMap[chi] = ci;
    }

    // Collect admin users (organization_admin role)
    final adminUsers = <AppUser>[alejandro];
    for (final s in staffUsers) {
      if (s.role == 'organization_admin') adminUsers.add(s);
    }

    // Staff assigned per classroom index:
    // Laura (admin) → all, Marc → Pollets + Ànecs, Nuria → Ovelles, Carla → Cavalls + Estrelles
    final classroomStaffMap = <int, List<AppUser>>{
      0: [staffUsers[1]], // Pollets: Marc
      1: [staffUsers[1]], // Ànecs: Marc
      2: [staffUsers[2]], // Ovelles: Nuria
      3: [staffUsers[3]], // Cavalls: Carla
      4: [staffUsers[3]], // Estrelles: Carla
    };

    final childConversations = <int, ChatConversation>{};
    for (var chi = 0; chi < children.length; chi++) {
      final child = children[chi];
      final childName = '${child.firstName} ${child.lastName}';

      final conv = await ChatConversation.db.insertRow(
        session,
        ChatConversation(
          organizationId: orgId,
          title: childName,
          conversationType: 'child_group',
          relatedChildId: child.id!,
          createdByUserId: alejandro.id!,
          isArchived: false,
          lastMessageAt: null,
          createdAt: now.subtract(const Duration(days: 5)),
          updatedAt: now,
        ),
      );
      childConversations[chi] = conv;

      // Collect participants: guardians + classroom staff + all admins
      final participantIds = <UuidValue>{};

      // Add guardians
      final guardianList = childGuardianMap[chi] ?? [];
      for (final g in guardianList) {
        participantIds.add(g.id!);
      }

      // Add classroom staff
      final classroomIdx = childClassroomMap[chi];
      if (classroomIdx != null) {
        final staff = classroomStaffMap[classroomIdx] ?? [];
        for (final s in staff) {
          participantIds.add(s.id!);
        }
      }

      // Add all admins
      for (final a in adminUsers) {
        participantIds.add(a.id!);
      }

      // Insert participants
      for (final userId in participantIds) {
        await ChatParticipant.db.insertRow(
          session,
          ChatParticipant(
            organizationId: orgId,
            conversationId: conv.id!,
            userId: userId,
            joinedAt: now,
            isActive: true,
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    }

    // Add sample messages to a few child chats
    // Leo (index 0) — Ana asks about his day
    final convLeo = childConversations[0]!;
    await ChatMessage.db.insert(session, [
      ChatMessage(
        organizationId: orgId,
        conversationId: convLeo.id!,
        senderUserId: guardians[0].id!, // Ana
        body: 'Buenos dias, queria preguntar como ha ido el dia de Leo.',
        messageType: 'text',
        sentAt: now.subtract(const Duration(hours: 3)),
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      ChatMessage(
        organizationId: orgId,
        conversationId: convLeo.id!,
        senderUserId: staffUsers[1].id!, // Marc
        body: 'Hola Ana! Leo ha tenido un dia estupendo. Ha comido bien y ha dormido la siesta completa.',
        messageType: 'text',
        sentAt: now.subtract(const Duration(hours: 2)),
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      ChatMessage(
        organizationId: orgId,
        conversationId: convLeo.id!,
        senderUserId: guardians[0].id!, // Ana
        body: 'Genial, muchas gracias!',
        messageType: 'text',
        sentAt: now.subtract(const Duration(hours: 1, minutes: 50)),
        createdAt: now.subtract(const Duration(hours: 1, minutes: 50)),
      ),
    ]);
    await ChatConversation.db.updateRow(
      session,
      convLeo.copyWith(
        lastMessageAt: now.subtract(const Duration(hours: 1, minutes: 50)),
      ),
    );

    // Mia (index 1) — Jordi asks about food
    final convMia = childConversations[1]!;
    await ChatMessage.db.insert(session, [
      ChatMessage(
        organizationId: orgId,
        conversationId: convMia.id!,
        senderUserId: guardians[1].id!, // Jordi
        body: 'Buenas tardes, Mia tiene intolerancia a la lactosa. Han tenido en cuenta eso en el almuerzo?',
        messageType: 'text',
        sentAt: now.subtract(const Duration(hours: 5)),
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      ChatMessage(
        organizationId: orgId,
        conversationId: convMia.id!,
        senderUserId: staffUsers[2].id!, // Nuria
        body: 'Si Jordi, siempre le preparamos el menu sin lactosa. Hoy ha comido muy bien!',
        messageType: 'text',
        sentAt: now.subtract(const Duration(hours: 4)),
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
    ]);
    await ChatConversation.db.updateRow(
      session,
      convMia.copyWith(
        lastMessageAt: now.subtract(const Duration(hours: 4)),
      ),
    );

    // Hugo (index 2) — Maria asks about asthma
    final convHugo = childConversations[2]!;
    await ChatMessage.db.insert(session, [
      ChatMessage(
        organizationId: orgId,
        conversationId: convHugo.id!,
        senderUserId: guardians[2].id!, // Maria
        body: 'Hola, Hugo ha mejorado del asma. El medico dice que ya no necesita inhalador.',
        messageType: 'text',
        sentAt: now.subtract(const Duration(hours: 8)),
        createdAt: now.subtract(const Duration(hours: 8)),
      ),
      ChatMessage(
        organizationId: orgId,
        conversationId: convHugo.id!,
        senderUserId: staffUsers[3].id!, // Carla
        body: 'Que buena noticia Maria! Lo anotamos en su ficha.',
        messageType: 'text',
        sentAt: now.subtract(const Duration(hours: 7)),
        createdAt: now.subtract(const Duration(hours: 7)),
      ),
    ]);
    await ChatConversation.db.updateRow(
      session,
      convHugo.copyWith(
        lastMessageAt: now.subtract(const Duration(hours: 7)),
      ),
    );

    // =========================================================
    // 18. DATA CHANGE REQUESTS (2)
    // =========================================================
    await DataChangeRequest.db.insert(session, [
      DataChangeRequest(
        organizationId: orgId,
        requesterUserId: guardians[0].id!, // Ana
        targetChildId: children[0].id!, // Leo
        requestType: 'update_contact',
        requestPayload: 'Nuevo teléfono de emergencia: +34 612 345 678',
        status: 'pending',
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      DataChangeRequest(
        organizationId: orgId,
        requesterUserId: guardians[2].id!, // María
        targetChildId: children[2].id!, // Hugo
        requestType: 'update_medical',
        requestPayload: 'Actualizar nota médica: ya no necesita inhalador para el asma.',
        status: 'approved',
        resolutionNote: 'Actualizado en el perfil del alumno.',
        reviewedByUserId: staffUsers[0].id!, // Laura
        reviewedAt: now,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now,
      ),
    ]);

    // =========================================================
    // 19. ONBOARDING STATES
    // =========================================================
    for (final guardian in guardians.take(4)) {
      await UserOnboardingState.db.insertRow(
        session,
        UserOnboardingState(
          organizationId: orgId,
          userId: guardian.id!,
          introCompletedAt: now,
          termsAcceptedAt: now,
          completedAt: now,
          createdAt: now,
          updatedAt: now,
        ),
      );
    }

    // =========================================================
    // 20. ACTIVITY LOG (sample entries)
    // =========================================================
    await ActivityLog.db.insert(session, [
      ActivityLog(
        organizationId: orgId,
        userId: alejandro.id!,
        action: 'bootstrap.seed',
        entityType: 'organization',
        entityId: orgId.toString(),
        metadata: 'Initial seed data',
        createdAt: now,
      ),
    ]);
  }
}
