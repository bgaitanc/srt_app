class ErrorMessageHelper {
  ErrorMessageHelper._();

  static String getFriendlyMessage(String technicalMessage) {
    final lowerMessage = technicalMessage.toLowerCase();

    // Error 401 - No autorizado
    if (lowerMessage.contains('401') || lowerMessage.contains('unauthorized')) {
      return 'Tu sesión ha expirado. Por favor, inicia sesión nuevamente.';
    }

    // Error 403 - Prohibido
    if (lowerMessage.contains('403') || lowerMessage.contains('forbidden')) {
      return 'No tienes permisos para acceder a este recurso.';
    }

    // Error 404 - No encontrado
    if (lowerMessage.contains('404') || lowerMessage.contains('not found')) {
      return 'No se encontró la información solicitada.';
    }

    // Error 500 - Error del servidor
    if (lowerMessage.contains('500') || lowerMessage.contains('internal server')) {
      return 'Ocurrió un error en el servidor. Intenta nuevamente más tarde.';
    }

    // Error de conexión
    if (lowerMessage.contains('connection') || 
        lowerMessage.contains('network') ||
        lowerMessage.contains('timeout')) {
      return 'No se pudo conectar al servidor. Verifica tu conexión a internet.';
    }

    // Error de timeout
    if (lowerMessage.contains('timeout')) {
      return 'La solicitud tardó demasiado. Intenta nuevamente.';
    }

    // Mensaje genérico si no coincide con ningún patrón
    return 'Ocurrió un error inesperado. Por favor, intenta nuevamente.';
  }

  static String getFriendlyMessageWithDetails(String technicalMessage, {bool showDetails = false}) {
    final friendlyMessage = getFriendlyMessage(technicalMessage);
    if (showDetails) {
      return '$friendlyMessage\n\nDetalles técnicos: $technicalMessage';
    }
    return friendlyMessage;
  }
}
