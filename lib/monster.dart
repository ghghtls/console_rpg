import 'package:console_rpg/utils.dart';

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

  void printAscii() {
    switch (monsterName.trim().toLowerCase()) {
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
  }
}
