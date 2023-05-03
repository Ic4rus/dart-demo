import 'dart:io';

List<int> bytes = [];
int headerOffset = 0;

void main() async {
  String path = "/Users/icarus/Workspaces/Rust/PdfFile/file_so1.pdf";
  bytes = readFile(path);
  headerOffset = getHeaderOffset();
  if (headerOffset != 0) {
    bytes = bytes.sublist(headerOffset, bytes.length - headerOffset);
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

void getStartxref() {
  int arrLength = 1024;
  int length = bytes.length;
  int pos = 0;
  while (true) {
    // String.fromCharCodes(bytes, start, end);
  }
}

