import 'dart:io';
import 'dart:math';

List<int> bytes = [];
int headerOffset = 0;
String tokenType = '';
List<int> outBuf = [];

void main() async {
  // String path = "/home/icarus/Downloads/pdf/file_so1.pdf";
  // bytes = readFile(path);
  // headerOffset = getHeaderOffset();
  // if (headerOffset != 0) {
  //   bytes = bytes.sublist(headerOffset, bytes.length - headerOffset);
  // }
  // readXref();
  int a = 32;
  if (String.fromCharCode(a) == ' ') {
    print('TRUE');
  } else {
    print('FALSE');
  }
  print("TEST");
}

List<int> readFile(String path) {
  var file = File(path);
  var uint8List = file.readAsBytesSync();
  return uint8List.toList();
}

int getHeaderOffset() {
  String str = String.fromCharCodes(bytes, 0, 1024);
  int idx = str.indexOf("%PDF-");
  if (idx < 0) {
    idx = str.indexOf("%FDF-");
    if (idx < 0) {
      throw 'PDF header not found';
    }
  }
  return idx;
}

void readPdf() {
  // version
  // XRef

}

void readXref() {
  int a = getStartxref();
  print('Test');
}

int getStartxref() {
  int fileLength = bytes.length;
  int bufLength = 1024;
  int pos = fileLength;
  do {
    pos = pos - bufLength + 9;
    String str = String.fromCharCodes(
        bytes, max(0, pos), min(pos + bufLength, fileLength)
    );
    int idx = str.lastIndexOf("startxref");
    if (idx >= 0) {
      return pos + idx;
    }
  } while (pos > 0);
  throw 'PDF startxref not found.';
}

bool nextToken(int pos) {
  int ch;
  do {
    ch = bytes[++pos];
  } while (ch != -1 && isWhitespace(ch));
  if (ch == -1) {
    // EndOfFile
    return false;
  }
  switch (String.fromCharCode(ch)) {
    case '[':
      // StartArray
      break;
    case ']':
      // EndArray
      break;
    case '/':
      // Name
      break;
    case '>':
      // EndDic
      break;
    case '<':
      // StartDic
      break;
    case '%':
      break;
    case '(':
      // String
      break;
  }
  return true;
}

bool isWhitespace(int ch) {
  return ch == 0 || ch == 9 || ch == 10 || ch == 12 || ch == 13 || ch == 32;
}

