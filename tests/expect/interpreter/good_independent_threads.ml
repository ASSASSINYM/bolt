open Core
open Print_execution

let%expect_test "Consume variable" =
  print_execution
    " 
    class Foo = linear Bar {
      var f : int
      const g : int  
      const h : int

    }
    class Choco = thread Late {
      const f : int
    }
    class Bana = read Na {
      const f : int
    }
    thread trait Late {
      require const f : int
    }
    read trait Na {
      require const f : int
    }
    linear trait Bar {
      require var f : int
      require const g : int  
      require const h : int
    }
  let x = new Choco(f:5) in 
      finish {
        async{
          let f = fun x : int -> x end in
            f 5
          end 
        }
        async{
          let y = new Choco(f:5) in 
            let z = new Bana(f:1) in 
              let w = new Foo(g:5) in 
                w.f := 5
              end
            end
          end
        }
      };
      x
  end
  " ;
  [%expect
    {|
    ----- Step 0 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); SPAWN [ PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]; MK_CLOSURE(BIND(x); STACK_LOOKUP(x); SWAP; POP); BIND(f); STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [  ]
    Heap: [  ]
    ------------------------------------------
    ----- Step 1 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(x); SPAWN [ PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]; MK_CLOSURE(BIND(x); STACK_LOOKUP(x); SWAP; POP); BIND(f); STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5 ]
    Heap: [  ]
    ------------------------------------------
    ----- Step 2 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ HEAP_FIELD_SET(f); BIND(x); SPAWN [ PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]; MK_CLOSURE(BIND(x); STACK_LOOKUP(x); SWAP; POP); BIND(f); STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Address: 1, Value: Int: 5 ]
    Heap: [ 1 -> { Class_name: Choco, Fields: {  } } ]
    ------------------------------------------
    ----- Step 3 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(x); SPAWN [ PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]; MK_CLOSURE(BIND(x); STACK_LOOKUP(x); SWAP; POP); BIND(f); STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Address: 1 ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 4 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SPAWN [ PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]; MK_CLOSURE(BIND(x); STACK_LOOKUP(x); SWAP; POP); BIND(f); STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 5 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 5); CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ MK_CLOSURE(BIND(x); STACK_LOOKUP(x); SWAP; POP); BIND(f); STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 6 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ MK_CLOSURE(BIND(x); STACK_LOOKUP(x); SWAP; POP); BIND(f); STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 7 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(f); STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]), Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 8 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ CONSTRUCTOR(Choco); HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 9 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ HEAP_FIELD_SET(f); BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Value: Int: 5, Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: {  } } ]
    ------------------------------------------
    ----- Step 10 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(f); PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 11 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ PUSH(Int: 5); APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]), Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 12 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ APPLY; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Value: Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]), Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 13 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BIND(x); STACK_LOOKUP(x); SWAP; POP; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 14 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ BIND(y); PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(x); SWAP; POP; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Int: 5 ], Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 15 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(x); SWAP; POP; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Int: 5 ], Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 16 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Int: 5 ], Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 17 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 1); CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Int: 5 ], Value: Int: 5, Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 18 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ CONSTRUCTOR(Bana); HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 1, Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Int: 5 ], Value: Int: 5, Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 19 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ HEAP_FIELD_SET(f); BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 3, Value: Int: 1, Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Int: 5 ], Value: Int: 5, Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: {  } } ]
    ------------------------------------------
    ----- Step 20 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Int: 5 ], Value: Int: 5, Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 3, Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } } ]
    ------------------------------------------
    ----- Step 21 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ BIND(z); PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 3, Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } } ]
    ------------------------------------------
    ----- Step 22 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ], Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } } ]
    ------------------------------------------
    ----- Step 23 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 5); CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 1 ], Value: Int: 5, Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } } ]
    ------------------------------------------
    ----- Step 24 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ CONSTRUCTOR(Foo); HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 1 ], Value: Int: 5, Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } } ]
    ------------------------------------------
    ----- Step 25 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 1 ], Value: Int: 5, Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 4, Value: Int: 5, Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: {  } } ]
    ------------------------------------------
    ----- Step 26 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ HEAP_FIELD_SET(g); BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 4, Value: Int: 5, Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: {  } } ]
    ------------------------------------------
    ----- Step 27 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ BIND(w); PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 4, Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 28 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 29 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ f -> Closure: ( Body: [ BIND(x); STACK_LOOKUP(x); SWAP; POP
      ] Env: [ x -> Address: 1 ]) ], Value: Int: 5, Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 30 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP; BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Int: 5, Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 31 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ PUSH(Int: 5); STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 32 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 33 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 34 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 35 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ STACK_LOOKUP(w); HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 36 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ HEAP_FIELD_SET(f); HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 4, Value: Int: 5, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5 } } ]
    ------------------------------------------
    ----- Step 37 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 4, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 38 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 4, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 39 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ HEAP_FIELD_LOOKUP(f); SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Address: 4, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 40 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ SWAP; POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ w -> Address: 4 ], Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 41 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ POP; SWAP; POP; SWAP; POP ]
       └──Stack: [ Env: [ w -> Address: 4 ], Value: Int: 5, Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 42 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 43 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ SWAP; POP; SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ z -> Address: 3 ], Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 44 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ POP; SWAP; POP ]
       └──Stack: [ Env: [ z -> Address: 3 ], Value: Int: 5, Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 45 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ SWAP; POP ]
       └──Stack: [ Value: Int: 5, Env: [ y -> Address: 2 ], Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 46 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [ POP ]
       └──Stack: [ Env: [ y -> Address: 2 ], Value: Int: 5, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 47 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [ POP ]
       └──Stack: [ Env: [ y -> Address: 2 ], Value: Int: 5, Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 48 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [  ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 49 - scheduled thread : 2-----
    Threads:
    └──Thread: 2
       └──Instructions: [  ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ] ]
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 50 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ BLOCKED; STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Value: Thread ID: 2, Env: [ x -> Address: 1 ] ]
    └──Thread: 2
       └──Instructions: [  ]
       └──Stack: [ Value: Int: 5, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 51 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ STACK_LOOKUP(x); SWAP; POP ]
       └──Stack: [ Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 52 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ SWAP; POP ]
       └──Stack: [ Value: Address: 1, Env: [ x -> Address: 1 ] ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 53 - scheduled thread : 1-----
    Threads:
    └──Thread: 1
       └──Instructions: [ POP ]
       └──Stack: [ Env: [ x -> Address: 1 ], Value: Address: 1 ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    ----- Step 54 - OUTPUT STATE --------
    Threads:
    └──Thread: 1
       └──Instructions: [  ]
       └──Stack: [ Value: Address: 1 ]
    Heap: [ 1 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 2 -> { Class_name: Choco, Fields: { f: Int: 5 } }, 3 -> { Class_name: Bana, Fields: { f: Int: 1 } }, 4 -> { Class_name: Foo, Fields: { g: Int: 5; f: Int: 5 } } ]
    ------------------------------------------
    Output: Address: 1 |}]
