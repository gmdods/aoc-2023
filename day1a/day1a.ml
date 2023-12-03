module Seq = struct
        include Seq
        let find_last pred =
                fold_left (fun opt elt -> if pred elt then Some elt else opt) None
        ;;
end

let find_digits line =
        let is_digit = function | '0'..'9' -> true | _ -> false in
        let offset = function
        | Some c -> (Char.code c - Char.code '0') | None -> 0 in
        let seq = String.to_seq line in
        let f = Seq.find is_digit seq |> offset in
        let l = Seq.find_last is_digit seq |> offset in
        f, l
;;
let calibrate_a line =
        let (f, l) = find_digits line in
        10 * f + l
;;
let () =
        let filename = if Array.length Sys.argv > 1
                then Array.get Sys.argv 1 else "day1/example_1a.txt" in
        let ch = open_in filename in
        let rec add_lines sum =
                match In_channel.input_line ch with
                | Some line -> add_lines (sum + calibrate_a line)
                | None -> sum
        in
        print_string "Sum : ";
        print_int (add_lines 0);
        print_newline ();
        close_in ch;
        ()
;;
