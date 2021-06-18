class Messages {
  late String message;
  late String timestamp;
  late String userName;

  Messages({required this.message, required this.timestamp});

  Messages.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    timestamp = json['timestamp'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['message'] = this.message;
    data['timestamp'] = this.timestamp;
    data['user_name'] = this.userName;

    return data;
  }
}
