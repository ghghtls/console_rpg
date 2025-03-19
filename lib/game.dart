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
  int itemattack(Character character) {
    int items = 0;
    character.attack * 2;

    return items;
  }

  int bonusHealth(Character character) {
    Random random = Random();
    double chance = random.nextDouble(); // 0.0 ~ 1.0 사이 랜덤 실수
    int bonus = 0; // 기본 0으로 시작
    if (chance < 0.3) {
      // 30% 확률
      bonus = Random().nextInt(11); // 0~10 사이 랜덤 보너스 체력
      character.hp += bonus;
    }
    return bonus; // 랜덤으로 증가한 실제 값 or 0
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
