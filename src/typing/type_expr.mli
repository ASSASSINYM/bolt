open Ast_types
open Core

val type_expr :
     trait_defn list
  -> class_defn list
  -> Parsed_ast.expr
  -> check_data_races:bool
  -> (Typed_ast.expr, Error.t) result
(** Type check expressions *)
