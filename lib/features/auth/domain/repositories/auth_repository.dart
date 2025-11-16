import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);

  Future<Either<Failure, User>> register({
    required String nombre,
    required String apellido,
    required String usuario,
    required String correo,
    required String telefono,
    required String password,
  });
}
