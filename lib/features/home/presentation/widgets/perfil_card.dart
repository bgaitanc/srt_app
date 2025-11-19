import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/info_row.dart';
import '../../../../core/widgets/primary_button.dart';

class PerfilCard extends StatelessWidget {
  final String usuario;
  final String nombres;
  final String apellidos;
  final String correo;
  final String telefono;
  final String miembroDesde;

  const PerfilCard({
    super.key,
    required this.usuario,
    required this.nombres,
    required this.apellidos,
    required this.correo,
    required this.telefono,
    required this.miembroDesde,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 38,
                backgroundColor: AppConstants.primaryColor,
                child: Text(
                  usuario.substring(0, 1).toUpperCase(),
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingXLarge),
              Text(
                '$nombres $apellidos',
                style: AppTextStyles.titleLarge(context),
              ),
              const SizedBox(height: AppConstants.spacingSmall),
              Text(
                '@$usuario',
                style: AppTextStyles.secondaryText(context),
              ),
              const SizedBox(height: AppConstants.spacingXLarge),
              const Divider(height: 1, thickness: 1, color: Colors.grey),
              const SizedBox(height: AppConstants.spacingXLarge),
              InfoRow(icon: Icons.email, value: correo),
              const SizedBox(height: AppConstants.spacingMedium),
              InfoRow(icon: Icons.phone, value: telefono),
              const SizedBox(height: AppConstants.spacingMedium),
              InfoRow(
                icon: Icons.calendar_today,
                value: 'Miembro desde $miembroDesde',
              ),
              const SizedBox(height: AppConstants.spacingXXLarge),
              PrimaryButton(
                label: 'Editar perfil',
                icon: Icons.edit,
                onPressed: () => _showEditModal(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditModal(BuildContext context) {
    final nombresController = TextEditingController(text: nombres);
    final apellidosController = TextEditingController(text: apellidos);
    final correoController = TextEditingController(text: correo);
    final telefonoController = TextEditingController(text: telefono);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Editar perfil',
                  style: AppTextStyles.titleMedium(context),
                ),
              ),
              const SizedBox(height: 18),
              _editField('Nombres', nombresController),
              const SizedBox(height: 12),
              _editField('Apellidos', apellidosController),
              const SizedBox(height: 12),
              _editField('Correo', correoController, keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 12),
              _editField('Teléfono', telefonoController, keyboardType: TextInputType.phone),
              const SizedBox(height: 24),
              PrimaryButton(
                label: 'Guardar',
                icon: Icons.save,
                isFullWidth: true,
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Perfil actualizado (demo)')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadiusMedium),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
      ),
      style: GoogleFonts.montserrat(fontSize: 16),
    );
  }

}
