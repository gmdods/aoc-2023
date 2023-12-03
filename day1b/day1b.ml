module Seq = struct
        include Seq
        let find_last pred =
                fold_left (fun opt elt -> if pred elt then Some elt else opt) None
        ;;
end

module String = struct
        include String
        let find_index str pat =
                let ch = get pat 0 in
                let sz = length pat in
                let ends  = length str in
                let rec find_index_rec i =
                        match index_from_opt str i ch with
                        | None -> ends
                        | Some j ->
                        if j + sz > ends then ends else
                        if starts_with ~prefix:pat (sub str j sz) then j
                        else find_index_rec (j + 1)

                in
                find_index_rec 0
        let find_last_index str pat =
                let ch = get pat 0 in
                let sz = length pat in
                let ends  = length str in
                let rec find_index_rec opt i =
                        let sentinel = Option.value ~default:(-1) opt in
                        match index_from_opt str i ch with
                        | None -> sentinel
                        | Some j ->
                        if j + sz > ends then sentinel
                        else find_index_rec
                        (if starts_with ~prefix:pat (sub str j sz)
                                then Some j else opt) (j + 1)

                in
                find_index_rec None 0

        ;;
end

let find_digits line =
        let sz = String.length line in
        let is_digit = function | '0'..'9' -> true | _ -> false in
        let is_digit_c (_, c) = is_digit c in
        let offset = function
        | Some (i, c) -> i, (Char.code c - Char.code '0')
        | None -> sz, 0
        in
        let seq = String.to_seqi line in
        let (fd, f) = Seq.find is_digit_c seq |> offset in
        let (ld, l) = Seq.find_last is_digit_c seq |> offset in
        fd, ld, f, l
;;
let calibrate_b line =
        let numbers = ["one"; "two"; "three"; "four"; "five";
                        "six"; "seven"; "eight"; "nine"] in
        let by_snd fn (a, i) (b, j) = if fn j i then (b, j) else (a, i) in
        let (fd, ld, f, l) = find_digits line in
        let (f, _) = numbers
        |> List.mapi (fun d num -> (1 + d, String.find_index line num))
        |> List.fold_left (by_snd (<)) (f, fd)
        in
        let (l, _) = numbers
        |> List.mapi (fun d num -> (1 + d, String.find_last_index line num))
        |> List.fold_left (by_snd (>)) (l, ld)
        in
        10 * f + l
;;
let () =
        let filename = if Array.length Sys.argv > 1
                then Array.get Sys.argv 1 else "day1/example_1b.txt" in
        let ch = open_in filename in
        let rec add_lines sum =
                match In_channel.input_line ch with
                | Some line -> add_lines (sum + calibrate_b line)
                | None -> sum
        in
        print_string "Sum : ";
        print_int (add_lines 0);
        print_newline ();
        close_in ch;
        ()
;;
