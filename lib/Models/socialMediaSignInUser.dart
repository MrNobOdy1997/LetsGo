class SmsUserData {
  String id;
  String userName;
  String mailId;
  bool sms;
  SmsUserData({required this.id,required this.userName,required this.mailId,required this.sms});
  Map<String, dynamic> toMap() {
    return {'id': id,'userName':userName,'mailId':mailId,'sms':sms};

  }

}