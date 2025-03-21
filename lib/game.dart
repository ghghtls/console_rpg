import 'dart:io';
import 'dart:math';
import 'package:console_rpg/character.dart';
import 'package:console_rpg/monster.dart';
import 'package:console_rpg/utils.dart';

class Game {
  Character character = Character();

  /// 캐릭터 객체 생성
  List<Monster> monsters = [];

  ///몬스터 객체 생성
  int downNumber = 0;

  ///등장 몬스터와 배틀 안맞는 부분 수정정
  void battle() {
    int bonus = bonusHealth(character);
    bool isWin = true;
    bool itemActive = false;
    int turnCounter = 0;

    Monster randomMonster = monsters[Random().nextInt(monsters.length)];
    print('새로운 몬스터가 나타났습니다!');
    randomMonster.printAscii();
    print(
      '${randomMonster.monsterName} - 체력: ${randomMonster.monsterHp}, 공격력: ${randomMonster.max}',
    );

    // 캐릭터 보너스
    if (bonus > 0) {
      print('${character.name}가 보너스 체력을 얻었습니다! 현재 체력: ${character.hp}');
      character.hp += bonus;
    } else {
      print('${character.name}가 보너스 체력을 못얻었습니다! 현재 체력: ${character.hp}');
    }

    while (true) {
      turnCounter++;
      print('${character.name}의 턴');
      print('행동을 선택하세요(1: 공격, 2: 방어, 3:아이템 사용)');
      String? number = stdin.readLineSync();

      if (number == '1') {
        int realAttack = character.attack;
        if (itemActive) {
          realAttack *= 2;
          itemActive = false;
        }
        int damage = realAttack - randomMonster.monsterDefense;
        if (damage < 0) damage = 0;
        randomMonster.monsterHp -= damage;

        print(
          '${character.name}이(가) ${randomMonster.monsterName}에게 $damage의 데미지를 입혔습니다.',
        );

        if (turnCounter % 3 == 0) randomMonster.increaseDefense();
      } else if (number == '2') {
        print('${character.name}이(가) 방어 태세를 취하여 $bonus 만큼 체력을 얻었습니다.');
        character.hp += bonus;
      } else if (number == '3') {
        if (!character.itemUsed) {
          print('${character.name}이(가) 한 턴 동안 공격력 두 배 아이템을 사용했습니다.');
          itemActive = true;
          character.itemUsed = true;
        } else {
          print('아이템은 이미 사용했습니다.');
        }
      } else {
        print('잘못 입력했습니다.');
        continue;
      }

      // 몬스터 죽음 처리
      if (randomMonster.monsterHp <= 0) {
        print('${randomMonster.monsterName}을(를) 물리쳤습니다.');
        monsters.remove(randomMonster);

        if (monsters.isEmpty) {
          print('축하합니다! 모든 몬스터를 물리쳤습니다');
          isWin = true;
          saveResult(isWin, character);
          break;
        }

        // 다음 몬스터 선택 여부
        print('다음 몬스터와 싸우시겠습니까? (y/n)');
        String? answer = stdin.readLineSync();
        if (answer == 'y' || answer == 'Y') {
          randomMonster = monsters[Random().nextInt(monsters.length)];
          print('새로운 몬스터가 나타났습니다!');
          randomMonster.printAscii();
          print(
            '${randomMonster.monsterName} - 체력: ${randomMonster.monsterHp}, 공격력: ${randomMonster.max}',
          );
          continue;
        } else {
          isWin = false;
          saveResult(isWin, character);
          break;
        }
      }

      // 몬스터 턴
      print('${randomMonster.monsterName}의 턴');
      print(
        '${randomMonster.monsterName}이(가) ${character.name}에게 ${randomMonster.max}의 데미지를 입혔습니다.',
      );
      character.hp -= randomMonster.max;

      if (character.hp <= 0) {
        print('${character.name}이(가) 쓰러졌습니다. 게임 오버');
        isWin = false;
        saveResult(isWin, character);
        break;
      }
    }
  }

  /* void showRandomMonster() {
    print('새로운 몬스터가 나타났습니다');
    Random random = Random();
    int randomIndex = random.nextInt(monsters.length);
    Monster randomMonster = monsters[randomIndex];
    randomMonster.printAscii();

    /// monster.dart에 넣은 메서드
    print(
      '${randomMonster.monsterName} - 체력: ${randomMonster.monsterHp}, 공격력: ${randomMonster.max}',
    );
  }*/

  int bonusHealth(Character character) {
    Random random = Random();
    double chance = random.nextDouble();

    /// 0.0 ~ 1.0 사이 랜덤 실수
    int bonus = 0;

    /// 기본 0으로 시작
    if (chance < 0.3) {
      /// 30% 확률
      bonus = Random().nextInt(11);

      /// 0~10 사이 랜덤 보너스 체력
      character.hp += bonus;
    }
    return bonus;

    /// 랜덤으로 증가한 실제 값 or 0
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
