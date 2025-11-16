import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class RegisterUser {
  final AuthRepository repository;

  RegisterUser(this.repository);

  Future<Either<Failure, User>> call({
    required String nombre,
    required String apellido,
    required String usuario,
    required String correo,
    required String telefono,
    required String password,
  }) async {
    return await repository.register(
      nombre: nombre,
      apellido: apellido,
      usuario: usuario,
      correo: correo,
      telefono: telefono,
      password: password,
    );
  }
}
