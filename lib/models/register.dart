class Register {
  final int code;
  final String? message;

  Register({required this.code, this.message});

  factory Register.formJosn(Map<String, dynamic> json) {
    return Register(code: json["code"], message: json["message"]);
  }
}
