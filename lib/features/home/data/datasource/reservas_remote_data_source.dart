import 'package:srt_app/core/constants/api_endpoints.dart';
import '../../../../features/utils/RemoteDataSourceBase.dart';
import '../../domain/entities/reserva_info_entity.dart';
import '../models/reserva_info_model.dart';
import '../../../utils/data/response_helper.dart';

class ReservasRemoteDataSource extends RemoteDataSourceBase {
  ReservasRemoteDataSource(super.dio);

  Future<List<ReservaInfoEntity>> getReservasByUser(int userId) async {
    final response = await safeRequest(
      () => dio.get(
        ApiEndpoints.reservasByUser,
        queryParameters: {'userId': userId},
      ),
    );

    return ResponseHelper.extractList<ReservaInfoEntity>(
      response,
      'data',
      (json) => ReservaInfoModel.fromJson(json),
    );
  }
}
