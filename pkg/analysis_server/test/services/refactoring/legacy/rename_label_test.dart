// Copyright (c) 2014, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:analyzer_plugin/protocol/protocol_common.dart';
import 'package:test/test.dart';
import 'package:test_reflective_loader/test_reflective_loader.dart';

import 'abstract_rename.dart';

void main() {
  defineReflectiveSuite(() {
    defineReflectiveTests(RenameLabelTest);
  });
}

@reflectiveTest
class RenameLabelTest extends RenameRefactoringTest {
  Future<void> test_checkNewName_LocalVariableElement() async {
    await indexTestUnit('''
void f() {
test:
  while (true) {
    break test;
  }
}
''');
    createRenameRefactoringAtString('test:');
    // empty
    refactoring.newName = '';
    assertRefactoringStatus(
      refactoring.checkNewName(),
      RefactoringProblemSeverity.FATAL,
      expectedMessage: 'Label name must not be empty.',
    );
    // OK
    refactoring.newName = 'newName';
    assertRefactoringStatusOK(refactoring.checkNewName());
  }

  Future<void> test_createChange() async {
    await indexTestUnit('''
void f() {
test:
  while (true) {
    break test;
  }
}
''');
    // configure refactoring
    createRenameRefactoringAtString('test:');
    expect(refactoring.refactoringName, 'Rename Label');
    expect(refactoring.elementKindName, 'label');
    refactoring.newName = 'newName';
    // validate change
    return assertSuccessfulRefactoring('''
void f() {
newName:
  while (true) {
    break newName;
  }
}
''');
  }

  Future<void> test_oldName() async {
    await indexTestUnit('''
void f() {
test:
  while (true) {
    break test;
  }
}
''');
    // configure refactoring
    createRenameRefactoringAtString('test:');
    // old name
    expect(refactoring.oldName, 'test');
  }
}
