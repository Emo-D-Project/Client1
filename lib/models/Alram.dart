class Alram {
  int id;
  int userId;
  bool allowMsg;
  bool msgAlarm;
  bool empAlarm;
  bool commAlarm;
  bool actAlarm;

  Alram({
    required this.id,
    required this.userId,
    required this.allowMsg,
    required this.msgAlarm,
    required this.empAlarm,
    required this.commAlarm,
    required this.actAlarm,
  });
}