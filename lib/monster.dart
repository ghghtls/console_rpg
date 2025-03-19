import 'package:console_rpg/character.dart';

class Monster {
  String monsterName;
  int monsterHp;
  int max;
  int monsterDefense;

  Monster({
    this.monsterName = "",
    this.monsterHp = 0,
    this.max = 0,
    this.monsterDefense = 0,
  });
  void increaseDefense() {
    monsterDefense += 2;
    print('$monsterName의 방어력이 증가했습니다! 현재 방어력: $monsterDefense');
  }

  void attackCharacter(Character character) {}
}
