(** Copyright 2024-2025, raf-nr and ksenmel *)

(** SPDX-License-Identifier: LGPL-3.0-or-later *)

open Ast.AbstractSyntaxTree
open Common.IdentifierStructs
open Common.IdentifierSearcher
open Common.StateMonad
open LlProgram

let start_env program =
  List.fold_left
    (fun acc decl ->
      match decl with
      | DOrdinary (case, cases) | DRecursive (case, cases) ->
        IdentifierSet.union acc (get_pattern_identifiers_from_cases (case :: cases)))
    IdentifierSet.empty
    program
;;

let run_ll_program program =
  let first_state = 0 in
  let m = ll_program start_env program in
  let result = run m first_state in
  fst result
;;
