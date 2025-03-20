import 'dart:io';

import 'package:console_rpg/character.dart';
import 'package:console_rpg/game.dart';
import 'package:console_rpg/monster.dart';
import 'package:console_rpg/utils.dart';
import 'dart:math';

///dart run
void main() {
  ///List<String> monsters = ['batman', 'spiderman', 'superman'];
  Game game = Game();
  //  사용자로부터 캐릭터 이름 입력
  String characterName = inputCharacterName();

  // 캐릭터 이름만 먼저 세팅
  game.character = Character(name: characterName);

  // ✅ hp, attack, defense는 파일에서 불러오기
  game.character.loadCharacterStats();

  //불러오려면 객체를 통해 불러와야한다. 객체가 지금 게임 클래스에 있다.
  print(
    "'$characterName' - 체력: '${game.character.hp}', 공격력: '${game.character.attack}', 방어력: '${game.character.defense}'",
  );
  game.loadAllMonsters();

  //로드 기능 몬스터.txt 파일에 몇마리 있는지 로드 기능
  print("몬스터 ${game.monsters.length}마리 로드 완료");
  print('새로운 몬스터가 나타났습니다');
  // 랜덤 인덱스 뽑기
  Random random = Random();
  int randomIndex = random.nextInt(game.monsters.length);

  // 랜덤 몬스터 출력
  var randomMonster = game.monsters[randomIndex];
  // 몬스터 이름에 맞춰 이미지 출력
  switch (randomMonster.monsterName.trim().toLowerCase()) {
    case 'batman':
      AsciiArt.batman();
      break;
    case 'spiderman':
      AsciiArt.spiderman();
      break;
    case 'superman':
      AsciiArt.superman();
      break;
    default:
      print('이미지 준비 안 된 몬스터입니다');
  }
  print(
    '${randomMonster.monsterName} - 체력: ${randomMonster.monsterHp}, 공격력: ${randomMonster.max}',
  );

  // 보너스 체력 지급 시도
  int bonus = game.bonusHealth(game.character);
  bool isWin = true; // 전역으로 먼저 선언
  bool itemActive = false; //  이번 턴에만 발동할지 체크
  int turnCounter = 0; // 턴 카운트용
  while (true) {
    turnCounter++; // 매 턴 증가
    print('$characterName의 턴');
    print('행동을 선택하세요(1: 공격, 2: 방어, 3:아이템 사용)');
    String? number = stdin.readLineSync();

    if (number == '1') {
      int realAttack = game.character.attack;
      if (itemActive) {
        realAttack *= 2; // 한 턴 동안 공격력 2배
        itemActive = false; // 턴 종료 후 효과 사라짐
      }
      // 몬스터 방어력 고려한 최종 데미지 계산
      int damage = realAttack - randomMonster.monsterDefense;
      if (damage < 0) damage = 0; // 방어력이 공격보다 높으면 0
      randomMonster.monsterHp -= damage;

      print(
        '$characterName이(가) ${randomMonster.monsterName}에게 $damage의 데미지를 입혔습니다.',
      );
      // 3턴마다 몬스터 방어력 증가
      if (turnCounter % 3 == 0) {
        randomMonster.increaseDefense();
      }
    } else if (number == '2') {
      print('$characterName이(가) 방어 태세를 취하여 $bonus 만큼 체력을 얻었습니다.');
      game.character.hp += bonus;
    } else if (number == '3') {
      //  캐릭터가 기억하고 있는 itemUsed 체크
      if (!game.character.itemUsed) {
        print('$characterName이(가) 한 턴 동안 공격력 두 배 아이템을 사용했습니다.');
        itemActive = true;
        game.character.itemUsed = true; // 캐릭터가 사용 처리
      } else {
        print('아이템은 이미 사용했습니다.');
      }
    } else {
      print('잘못 입력했습니다.');
      continue;
    }

    /// 몬스터 체력 체크
    if (randomMonster.monsterHp <= 0) {
      print('${randomMonster.monsterName}을(를) 물리쳤습니다.');

      /// 리스트에서 해당 몬스터 삭제 (완전히 제거)
      game.monsters.remove(randomMonster);

      /// 남은 몬스터가 없으면 승리 처리
      if (game.monsters.isEmpty) {
        print('축하합니다! 모든 몬스터를 물리쳤습니다');
        isWin = true;
        saveResult(isWin, game.character);
        break;
      }

      //  다음 몬스터 싸울지 물어봄
      print('다음 몬스터와 싸우시겠습니까? (y/n)');
      String? answer = stdin.readLineSync();
      if (answer == 'y' || answer == 'Y') {
        // 남아있는 몬스터 중 랜덤 소환
        randomMonster = game.monsters[Random().nextInt(game.monsters.length)];
        print('새로운 몬스터가 나타났습니다');
        switch (randomMonster.monsterName.trim().toLowerCase()) {
          case 'batman':
            AsciiArt.batman();
            break;
          case 'spiderman':
            AsciiArt.spiderman();
            break;
          case 'superman':
            AsciiArt.superman();
            break;
          default:
            print('이미지 준비 안 된 몬스터입니다');
        }
        print(
          '${randomMonster.monsterName} - 체력: ${randomMonster.monsterHp}, 공격력: ${randomMonster.max}',
        );
        continue;
      } else {
        isWin = false;
        saveResult(isWin, game.character);
        break;
      }
    }

    // 몬스터 공격 턴
    print('${randomMonster.monsterName}의 턴');
    print(
      '${randomMonster.monsterName}이(가) $characterName에게 ${randomMonster.max}의 데미지를 입혔습니다.',
    );
    game.character.hp -= randomMonster.max;

    if (game.character.hp <= 0) {
      print('$characterName이(가) 쓰러졌습니다. 게임 오버');
      isWin = false; // 게임 오버니까 패배
      saveResult(isWin, game.character);
      break;
    }
  }
}
