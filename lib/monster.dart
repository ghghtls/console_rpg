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

  void attackCharacter(Character character) {}
}
