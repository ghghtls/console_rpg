### README 

<h1 align="center">
콘솔 전투 RPG 게임 과제
</h1>
<p align="center">
</p>

## 프로젝트 개요
콘솔 전투 RPG 게임

### 프로젝트 일정
YY/MM/DD~YY/MM/DD



## 주요 기능

- [ ]| 파일로부터 데이터 읽어오기 기능 | 

- [ ]| 사용자로부터 캐릭터 이름 입력받기 기능| 

- [ ]| 게임 종료 후 결과를 파일에 저장하는 기능 | 

- [ ]| 캐릭터의 체력 증가 기능 추가 | 

- [ ]| 전투 시 캐릭터의 아이템 사용 기능 추가 | 

- [ ]| 몬스터의 방어력 증가 기능 추가 | 

- [ ]| 몬스터.txt 파일에 몇마리 있는지 로드 기능| 

- [ ]|  아스키아트로 게임캐릭터 괴물캐릭터 이미지 나타나는는 기능| 

- [ ]|  결과 파일 내용을 유지하고, 새 결과를 파일 끝에 추가 저장| 



<br/>

## TroubleShooting

문제- 정규식에서 한글을 못읽는 문제 

해결-
```
RegExp nameRegExp = RegExp(r'^[a-zA-Z가-힣]+$');
```
를 아래로 바꿔줌
```dart
RegExp nameRegExp = RegExp(r'^[\uAC00-\uD7A3a-zA-Z]+$');

```
```dart
inputName = stdin.readLineSync(encoding: utf8)!.trim();
```
utf8로 변경해줘야 한글 읽을 수 있음

문제 - 리스트 객체 바로 불러오려다 한 오류

```dart
game.monster.loadMonsterStats();
```
해결 -게임클래스에 
```dart
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
```
입력 후 메인메서드에
```dart
game.loadAllMonsters();
```
로 불러오기

문제- for문 말고 랜덤함수로 몬스터 불러오기
```
  // print("새로운 몬스터가 나타났습니다");
  // for (int i = 0; i < game.monsters.length; i++) {
  //   print(
  //     '${game.monsters[i].monsterName} - 체력: ${game.monsters[i].monsterHp},공격력:${game.monsters[i].max}',
  //   );
  // }
```
해결-
```dart
 // 랜덤 인덱스 뽑기
  Random random = Random();
  int randomIndex = random.nextInt(game.monsters.length);

  // 랜덤 몬스터 출력
  var randomMonster = game.monsters[randomIndex];
  print(
    '${randomMonster.monsterName} - 체력: ${randomMonster.monsterHp}, 공격력: ${randomMonster.max}',
  );
```
문제- 랜덤 몬스터 변수명 고정인지 헷갈린 문제

해결-
```
// 한 번만 랜덤 뽑기
var randomMonster = game.monsters[Random().nextInt(game.monsters.length)];
print('${randomMonster.monsterName}의 턴');  // ✅ 이건 "뽑힌 몬스터"가 고정됨

```
```
// 매번 새로 뽑으면?
print('${game.monsters[Random().nextInt(game.monsters.length)].monsterName}의 턴'); // ✅ 매번 랜덤

```

이런식으로 차이가 있음 그래서 내가 쓴 코드는 변수명 고정.



<br/>

