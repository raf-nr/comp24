(** Copyright 2024-2025, raf-nr and ksenmel *)

(** SPDX-License-Identifier: LGPL-3.0-or-later *)

open Ast.AbstractSyntaxTree

type immexpr = 
  | ImmConst of constant
  | ImmVar of string

type cexpr =
  | CApplication of immexpr * immexpr * immexpr list
  | CImmExpr of immexpr

and aexpr =
  | ALet of string * cexpr * aexpr
  | ACExpr of cexpr

let rec anf (e : expression) : aexpr =
  match e with
  | EConstant c -> ACExpr (CImmExpr(ImmConst c))
  | _ -> failwith "Not Implemented"
