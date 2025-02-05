(** Copyright 2024-2025, raf-nr and ksenmel *)

(** SPDX-License-Identifier: LGPL-3.0-or-later *)

open Parser.Runner

let%expect_test _ =
  parse_with_print {| 1 + 1 |};
  [%expect
    {|
    [(SExpression
        (EApplication ((EIdentifier (Id "( + )")),
           [(EConstant (CInt 1)); (EConstant (CInt 1))])))
      ] |}]
;;

let%expect_test _ =
  parse_with_print {| 1 + 2 * 3 |};
  [%expect{|
    [(SExpression
        (EApplication ((EIdentifier (Id "( + )")),
           [(EConstant (CInt 1));
             (EApplication ((EIdentifier (Id "( * )")),
                [(EConstant (CInt 2)); (EConstant (CInt 3))]))
             ]
           )))
      ] |}]
;;

let%expect_test _ =
  parse_with_print {| 1 + 2 / 3 |};
  [%expect]
;;

let%expect_test _ =
  parse_with_print {| (1 + 2) * (3 + 4) / (1 + (2 * 3)) |};
  [%expect]
;;

let%expect_test _ =
  parse_with_print {| 1 < 2 && 2 > 1 |};
  [%expect]
;;

let%expect_test _ =
  parse_with_print {| 1 <= 2 || 3 >= 2 |};
  [%expect]
;;

let%expect_test _ =
  parse_with_print {| 1 <> 2 && 3 != 4 || 1 =|};
  [%expect]
;;

let%expect_test _ =
  parse_with_print {| (1 * 2 + 3 / 3) >= (3 / 3 / 3) || (1 != 9 / 3) |};
  [%expect]
;;
