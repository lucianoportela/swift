// RUN: %target-swift-frontend -primary-file %s -emit-ir -g -o - | FileCheck %s

class DeepThought {
  func query() -> Int64 { return 42 }
}

func foo() -> Int64 {
  // CHECK: call void @llvm.dbg.declare(metadata %C3let11DeepThought** {{.*}}, metadata ![[A:.*]], metadata !{{[0-9]+}})
  // CHECK ![[A]] = {{.*}}i32 0} ; [ DW_TAG_auto_variable ] [machine] [line [[@LINE+1]]]
  // CHECK: !DILocalVariable(tag: DW_TAG_auto_variable, name: "machine"
  // CHECK-NOT:              flags:
  // CHECK-SAME:             line: [[@LINE+1]],
  let machine = DeepThought()
  // CHECK: !DILocalVariable(tag: DW_TAG_auto_variable, name: "a"
  // CHECK-SAME:             line: [[@LINE+1]],
  let a = machine.query()
  return a
}
