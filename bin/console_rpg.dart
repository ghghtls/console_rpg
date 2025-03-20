import 'package:console_rpg/character.dart';
import 'package:console_rpg/game.dart';
import 'package:console_rpg/monster.dart';
import 'package:console_rpg/utils.dart';

///dart run
void main() {
  Game game = Game();
  //  사용자로부터 캐릭터 이름 입력
  String characterName = inputCharacterName();

  // 캐릭터 이름만 먼저 세팅
  game.character = Character(name: characterName);

  // ✅ hp, attack, defense는 파일에서 불러오기
  game.character.loadCharacterStats();

  game.loadAllMonsters();
  //불러오려면 객체를 통해 불러와야한다. 객체가 지금 게임 클래스에 있다.
  print(
    "'$characterName' - 체력: '${game.character.hp}', 공격력: '${game.character.attack}', 방어력: '${game.character.defense}'",
  );
  //로드 기능 몬스터.txt 파일에 몇마리 있는지 로드 기능
  print("몬스터 ${game.monsters.length}마리 로드 완료");

  game.showRandomMonster();
  game.battle();
}
