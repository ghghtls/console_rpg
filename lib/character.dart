import 'dart:io';

class Character {
  String name;
  int hp;
  int attack;
  int defense;
  bool itemUsed = false;

  /// 아이템 사용 여부 저장용 변수 추가
  Character({this.name = "", this.hp = 0, this.attack = 0, this.defense = 0});

  void loadCharacterStats() {
    try {
      final file = File('assets/characters.txt');
      final contents = file.readAsStringSync();
      final stats = contents.split(',');
      if (stats.length != 3) throw FormatException('Invalid character data');

      hp = int.parse(stats[0]);
      attack = int.parse(stats[1]);
      defense = int.parse(stats[2]);
    } catch (e) {
      print('캐릭터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }
}
