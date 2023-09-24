class PayDebtsResponse {
  double pay;
  int userCode;
  bool successRequest;

  PayDebtsResponse({
    required this.userCode,
    required this.pay,
    required this.successRequest,
  });

  // Función para crear una instancia de PayDebtsResponse a partir de un mapa (JSON)
  factory PayDebtsResponse.fromJson(Map<String, dynamic> json) {
    return PayDebtsResponse(
      pay: json['pay'] ?? 0.0,
      userCode: json['userCode'] ?? 0,
      successRequest: json['successRequest'] ?? false,
    );
  }

  // Función para convertir la instancia de PayDebtsResponse a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'pay': pay,
      'userCode': userCode,
      'successRequest': successRequest,
    };
  }

  // Función para convertir la instancia de PayDebtsResponse a una cadena de texto
  @override
  String toString() {
    return 'PayDebtsResponse{pay: $pay, userCode: $userCode, successRequest: $successRequest}';
  }
}
