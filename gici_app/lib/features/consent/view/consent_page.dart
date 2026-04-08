import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../app/widgets/error_state.dart';
import '../../../app/widgets/gici_card.dart';
import '../../../app/widgets/loading_state.dart';
import '../../../app/widgets/section_header.dart';
import '../../../app/widgets/status_pill.dart';
import '../../../core/di/injection.dart';
import '../cubit/consent_cubit.dart';
import '../data/consent_repository.dart';

class ConsentPage extends StatelessWidget {
  const ConsentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConsentCubit(
        repository: sl<ConsentRepository>(),
      )..load(),
      child: const _ConsentView(),
    );
  }
}

class _ConsentView extends StatelessWidget {
  const _ConsentView();

  // Consent type metadata
  static const _consentTypes = [
    (
      type: 'rgpd',
      label: 'RGPD - Proteccion de datos',
      description:
          'Consentimiento para el tratamiento de datos personales segun el Reglamento General de Proteccion de Datos.',
      icon: Icons.shield_outlined,
      color: Colors.blue,
    ),
    (
      type: 'fotos',
      label: 'Fotografias y videos',
      description:
          'Autorizacion para tomar y compartir fotografias y videos del alumno en actividades del centro.',
      icon: Icons.camera_alt_outlined,
      color: Colors.purple,
    ),
    (
      type: 'datos_medicos',
      label: 'Datos medicos',
      description:
          'Consentimiento para almacenar y gestionar informacion medica relevante del alumno.',
      icon: Icons.medical_information_outlined,
      color: Colors.red,
    ),
    (
      type: 'comunicaciones',
      label: 'Comunicaciones',
      description:
          'Autorizacion para recibir comunicaciones, notificaciones y circulares del centro.',
      icon: Icons.mail_outlined,
      color: Colors.teal,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConsentCubit, ConsentState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF5F5F7),
          appBar: AppBar(
            title: const Text(
              'Consentimientos',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: () => context.go('/direccion'),
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => context.read<ConsentCubit>().load(),
            child: _buildBody(context, state),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, ConsentState state) {
    if (state.isLoading) {
      return const LoadingState(message: 'Cargando consentimientos...');
    }

    if (state.errorMessage != null) {
      return ErrorState(
        message: state.errorMessage!,
        onRetry: () => context.read<ConsentCubit>().load(),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionHeader(
          title: 'Gestion de consentimientos',
          icon: '\u{1F512}',
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            'Gestiona tus autorizaciones y consentimientos. Puedes activar o desactivar cada uno en cualquier momento.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
            ),
          ),
        ),
        ..._consentTypes.map((ct) {
          final isAccepted = _isConsentAccepted(state.consents, ct.type);
          return _ConsentToggleCard(
            label: ct.label,
            description: ct.description,
            icon: ct.icon,
            color: ct.color,
            isAccepted: isAccepted,
            isActing: state.isActing,
            onToggle: (value) {
              final cubit = context.read<ConsentCubit>();
              if (value) {
                cubit.accept(consentType: ct.type);
              } else {
                cubit.revoke(consentType: ct.type);
              }
            },
          );
        }),
        const SizedBox(height: 32),
      ],
    );
  }

  bool _isConsentAccepted(List<dynamic> consents, String type) {
    for (final c in consents) {
      if ((c.consentType as String?) == type && (c.isAccepted as bool?) == true) {
        return true;
      }
    }
    return false;
  }
}

// ---------------------------------------------------------------------------
// Consent toggle card
// ---------------------------------------------------------------------------

class _ConsentToggleCard extends StatelessWidget {
  const _ConsentToggleCard({
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
    required this.isAccepted,
    required this.isActing,
    required this.onToggle,
  });

  final String label;
  final String description;
  final IconData icon;
  final Color color;
  final bool isAccepted;
  final bool isActing;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return GiciCard(
      accentColor: isAccepted ? color : Colors.grey.shade300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    StatusPill(
                      label: isAccepted ? 'Aceptado' : 'Pendiente',
                      color: isAccepted ? Colors.green : Colors.orange,
                      small: true,
                    ),
                  ],
                ),
              ),
              Switch(
                value: isAccepted,
                onChanged: isActing ? null : onToggle,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 56),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
