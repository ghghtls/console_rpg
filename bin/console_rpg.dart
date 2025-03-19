import 'package:console_rpg/character.dart';
import 'package:console_rpg/game.dart';
import 'package:console_rpg/monster.dart';
import 'package:console_rpg/utils.dart';
import 'dart:math';

void main() {
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
  // 랜덤 인덱스 뽑기
  Random random = Random();
  int randomIndex = random.nextInt(game.monsters.length);

  // 랜덤 몬스터 출력
  var randomMonster = game.monsters[randomIndex];
  print(
    '${randomMonster.monsterName} - 체력: ${randomMonster.monsterHp}, 공격력: ${randomMonster.max}',
  );
  // print("새로운 몬스터가 나타났습니다");
  // for (int i = 0; i < game.monsters.length; i++) {
  //   print(
  //     '${game.monsters[i].monsterName} - 체력: ${game.monsters[i].monsterHp},공격력:${game.monsters[i].max}',
  //   );
  // }

  bool isWin = true; // 또는 false로 패배 시뮬레이션

  // ✅ 게임 결과 저장
  saveResult(isWin, game.character);

  print("캐릭터 이름이 '${game.character.name}'으로 설정되었습니다.");
}
