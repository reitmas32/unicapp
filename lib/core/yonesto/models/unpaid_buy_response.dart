class UnpaidBuyResponse {
  double totalRemainingAmount;
  int numberBuys;
  bool successRequest;

  UnpaidBuyResponse({
    required this.totalRemainingAmount,
    required this.numberBuys,
    required this.successRequest,
  });

  // Función para crear una instancia de UnpaidBuyResponse a partir de un mapa (JSON)
  factory UnpaidBuyResponse.fromJson(Map<String, dynamic> json) {
    return UnpaidBuyResponse(
      totalRemainingAmount: json['totalRemainingAmount'] ?? 0.0,
      numberBuys: json['numberBuys'] ?? 0,
      successRequest: json['successRequest'] ?? false,
    );
  }

  // Función para convertir la instancia de UnpaidBuyResponse a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'totalRemainingAmount': totalRemainingAmount,
      'numberBuys': numberBuys,
      'successRequest': successRequest,
    };
  }

  // Función para convertir la instancia de UnpaidBuyResponse a una cadena de texto
  @override
  String toString() {
    return 'UnpaidBuyResponse{totalRemainingAmount: $totalRemainingAmount, numberBuys: $numberBuys, successRequest: $successRequest}';
  }
}
