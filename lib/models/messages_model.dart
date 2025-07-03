class MessagesModel {
  final String message;
  final String email;

  MessagesModel(this.message, this.email);

  factory MessagesModel.fromJson(jsonData) {
    return MessagesModel(
      jsonData['message'],
      jsonData['email'] ?? '',
    );
  }
}
