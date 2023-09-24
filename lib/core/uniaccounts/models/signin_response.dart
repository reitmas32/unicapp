class SignInResponse {
  bool success;
  String? message;
  String? jwt;
  // List<Product> data;

  SignInResponse({
    required this.success,
    this.message,
    this.jwt,
    //required this.data,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> map) {
    final success = map['Success'] as bool;
    final message = map['Message'] as String;
    final jwt = map['Data']?['token_jwt'] as String;

    return SignInResponse(
      success: success,
      message: message,
      jwt: jwt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Success': success,
      'Message': message,
      'Data': {
        'jwt': jwt,
      }
      //'Data': data.map((product) => product.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return '';
    //return 'SignInResponse(success: $success, message: $message, data: $data,)';
  }
}
