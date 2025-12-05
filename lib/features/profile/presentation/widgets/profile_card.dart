import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/presentation/widgets/cards/info_row.dart';
import '../../../../core/presentation/widgets/buttons/primary_button.dart';
import '../../../auth/domain/usecases/update_profile_params.dart';
import '../bloc/user_info_bloc.dart';
import '../bloc/user_info_event.dart';
import '../bloc/user_info_state.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String name;
  final String surname;
  final String email;
  final String phoneNumber;

  const ProfileCard({
    super.key,
    required this.username,
    required this.name,
    required this.surname,
    required this.email,
    required this.phoneNumber,
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
      builder: (modalContext) => Padding(
        padding: EdgeInsets.only(
          left: 24,
          right: 24,
          top: 24,
          bottom: MediaQuery.of(modalContext).viewInsets.bottom + 24,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Editar perfil',
                  style: AppTextStyles.titleMedium(modalContext),
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
                  Navigator.of(modalContext).pop();
                  _handleProfileUpdate(
                    context,
                    nameController.text,
                    surnameController.text,
                    emailController.text,
                    phoneNumberController.text,
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

  void _handleProfileUpdate(
    BuildContext context,
    String newName,
    String newSurname,
    String newEmail,
    String newPhoneNumber,
  ) {
    // Cache ScaffoldMessenger before async operations
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    
    // Dispatch the update event
    context.read<UserInfoBloc>().add(
      UpdateUserProfileEvent(
        UpdateProfileParams(
          name: newName,
          surname: newSurname,
          email: newEmail,
          phoneNumber: newPhoneNumber,
        ),
      ),
    );

    // Listen for the result
    final subscription = context.read<UserInfoBloc>().stream.listen((state) {
      if (state is UserInfoLoaded) {
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text('Perfil actualizado exitosamente'),
            backgroundColor: Colors.green,
          ),
        );
      } else if (state is UserInfoError) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text('Error al actualizar perfil: ${state.failure}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

    // Cancel subscription after a short delay to avoid memory leaks
    Future.delayed(const Duration(seconds: 3), () {
      subscription.cancel();
    });
  }
}
