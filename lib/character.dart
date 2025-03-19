import 'dart:io';
import 'package:console_rpg/monster.dart';

class Character {
  String name;
  int hp;
  int attack;
  int defense;

  Character({this.name = "", this.hp = 0, this.attack = 0, this.defense = 0});

  void attackMonster(Monster monster) {}

  void defend() {}

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
