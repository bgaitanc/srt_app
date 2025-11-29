import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/presentation/widgets/cards/info_row.dart';
import '../../../../core/presentation/widgets/buttons/primary_button.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;
  final String memberSince;

  const ProfileCard({
    super.key,
    required this.username,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
    required this.memberSince,
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
                  username.substring(0, 1).toUpperCase(),
                  style: GoogleFonts.montserrat(
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.spacingXLarge),
              Text('$name $surname', style: AppTextStyles.titleLarge(context)),
              const SizedBox(height: AppConstants.spacingSmall),
              Text('@$username', style: AppTextStyles.secondaryText(context)),
              const SizedBox(height: AppConstants.spacingXLarge),
              const Divider(height: 1, thickness: 1, color: Colors.grey),
              const SizedBox(height: 16),
              InfoRow(icon: Icons.person, label: 'Usuario', value: username),
              const SizedBox(height: 8),
              InfoRow(icon: Icons.email, label: 'Correo', value: email),
              const SizedBox(height: 8),
              InfoRow(icon: Icons.phone, label: 'Teléfono', value: phoneNumber),
              const SizedBox(height: 24),
              InfoRow(
                icon: Icons.calendar_today,
                label: 'Miembro desde',
                value: memberSince,
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
    final nameController = TextEditingController(text: name);
    final surnameController = TextEditingController(text: surname);
    final emailController = TextEditingController(text: email);
    final phoneNumberController = TextEditingController(text: phoneNumber);

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
              _editField('Nombres', nameController),
              const SizedBox(height: 12),
              _editField('Apellidos', surnameController),
              const SizedBox(height: 12),
              _editField(
                'Correo',
                emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 12),
              _editField(
                'Teléfono',
                phoneNumberController,
                keyboardType: TextInputType.phone,
              ),
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

  Widget _editField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
  }) {
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
