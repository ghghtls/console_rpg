import 'dart:io';
import 'dart:math';
import 'package:console_rpg/character.dart';
import 'package:console_rpg/monster.dart';

class Game {
  Character character = Character(); // 캐릭터 객체 생성
  List<Monster> monsters = []; //몬스터 객체 생성
  int downNumber = 0;

  void startGame() {}
  void battle() {}
  void getRandomMonster() {}
  void bonusHealth(Character character) {
    Random random = Random();
    double chance = random.nextDouble(); // 0.0 ~ 1.0 사이 랜덤 실수

    if (chance < 0.3) {
      // 30% 확률
      character.hp += 10;
      print('보너스 체력을 얻었습니다! 현재 체력: ${character.hp}');
    }
  }

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
