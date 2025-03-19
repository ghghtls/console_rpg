import 'dart:io';
import 'package:console_rpg/character.dart';
import 'package:console_rpg/monster.dart';

class Game {
  Character character = Character(); // 캐릭터 객체 생성
  List<Monster> monsters = []; //몬스터 객체 생성
  int downNumber = 0;

  void startGame() {}
  void battle() {}
  void getRandomMonster() {}

  void loadAllMonsters() {
    try {
      final file = File('assets/monsters.txt');
      final lines = file.readAsLinesSync();

      for (var line in lines) {
        final stats = line.split(',');
        if (stats.length != 3) throw FormatException('Invalid monster data');

        monsters.add(
          Monster(
            monsterName: stats[0],
            monsterHp: int.parse(stats[1]),
            max: int.parse(stats[2]),
          ),
        );
      }
    } catch (e) {
      print('몬스터 데이터를 불러오는 데 실패했습니다: $e');
      exit(1);
    }
  }
}
