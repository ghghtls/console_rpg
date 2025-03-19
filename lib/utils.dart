import 'dart:convert';
import 'dart:io';

/// 사용자로부터 캐릭터 이름 입력받는 기능 (정규식 포함)
String inputCharacterName() {
  String inputName;

  while (true) {
    // 수정: '가-힣' 은 완성형 한글이긴 하나, 터미널 한글 입력 깨짐 방지용으로 utf8 읽기 권장
    RegExp nameRegExp = RegExp(r'^[\uAC00-\uD7A3a-zA-Z]+$'); // ✅ 유니코드 한글 범위로 수정

    while (true) {
      stdout.write("캐릭터 이름을 입력하세요 (한글/영문만 허용): ");
      inputName = stdin.readLineSync(encoding: utf8)!.trim(); // ✅ utf8로 읽기 추가
      print(inputName);

      if (inputName.isEmpty) {
        print("이름은 비어있을 수 없습니다.\n");
        continue;
      }

      if (!nameRegExp.hasMatch(inputName)) {
        print("이름에 숫자나 특수문자가 포함될 수 없습니다.\n");
        continue;
      }
      print('게임을 시작합니다');
      break;
    }
    return inputName;
  }
}

///  게임 결과 저장 기능
void saveResult(bool isWin, dynamic character) {
  stdout.write("결과를 저장하시겠습니까? (y/n): ");
  String? input = stdin.readLineSync();

  if (input != null && input.toLowerCase() == 'y') {
    String result = isWin ? "승리" : "패배";
    String content =
        "캐릭터 이름: ${character.name}\n"
        "남은 체력: ${character.hp}\n"
        "게임 결과: $result\n";

    try {
      final file = File('assets/result.txt');
      file.writeAsStringSync(content);
      print("결과가 'result.txt' 파일에 저장되었습니다.");
    } catch (e) {
      print("결과 저장 중 오류 발생: $e");
    }
  } else {
    print("결과 저장을 취소했습니다.");
  }
}
