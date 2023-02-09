import 'dart:convert';

class Player {
  final String nickName;
  final String socketId;
  final double points;
  final String playerType;

  Player(
      {required this.nickName,
      required this.socketId,
      required this.points,
      required this.playerType});

  Map<String, dynamic> toMap() {
    return {
      "nickName": nickName,
      "socketId": socketId,
      "points": points,
      "playerType": playerType
    };
  }

  factory Player.fromMap(Map<String, dynamic> map) {
    return Player(
        nickName: map["nickName"] ?? '',
        socketId: map["socketId"] ?? '',
        points: map["points"] ?? 0,
        playerType: map["playerType"] ?? '');
  }

  String toJson() => jsonEncode(toMap());

  factory Player.fromJson(String source) => Player.fromMap(jsonDecode(source));

  Player copyWith(String? nickName, String? socketId, double? points,
          String? playerType) =>
      Player(
          nickName: nickName ?? this.nickName,
          socketId: socketId ?? this.socketId,
          points: points ?? this.points,
          playerType: playerType ?? this.playerType);
}
