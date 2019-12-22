open Core
open Print_typed_ast

let%expect_test "Good if statement" =
  print_typed_ast
    " 
   {
     let x = true;
     if x {
       0
     }
     else {
       1
     }
   }
  " ;
  [%expect
    {|
      Program
      └──Expr: Block
         └──Type expr: Int
         └──Expr: Let var: x
            └──Type expr: Bool
            └──Expr: Bool:true
         └──Expr: If
            └──Type expr: Int
            └──Expr: Variable: x
               └──Type expr: Bool
            └──Expr: Block
               └──Type expr: Int
               └──Expr: Int:0
            └──Expr: Block
               └──Type expr: Int
               └──Expr: Int:1 |}]

let%expect_test "Good while loop" =
  print_typed_ast " 
   while (1 < 2){
     let x = 5
   }
  " ;
  [%expect
    {|
      Program
      └──Expr: While
         └──Type expr: ()
         └──Expr: Bin Op: <
            └──Type expr: Bool
            └──Expr: Int:1
            └──Expr: Int:2
         └──Expr: Block
            └──Type expr: Int
            └──Expr: Let var: x
               └──Type expr: Int
               └──Expr: Int:5 |}]

let%expect_test "Good for loop" =
  print_typed_ast " 
   for i in range(0, (5*5), 1) {
     i
   }
  " ;
  [%expect
    {|
      Program
      └──Expr: For: loop var: i
         └──Type expr: ()
         └──Expr: Int:0
         └──Expr: Bin Op: *
            └──Type expr: Int
            └──Expr: Int:5
            └──Expr: Int:5
         └──Expr: Int:1
         └──Expr: Block
            └──Type expr: Int
            └──Expr: Variable: i
               └──Type expr: Int |}]