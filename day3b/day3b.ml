module List = struct
        include List
        let generate fopt init =
                let rec aux list = function
                | None -> list
                | Some (r, t) -> aux ((r, t)::list) (fopt t)
                in
                aux [] (fopt init)
        ;;
end
module String = struct
        include String
        let find_next pred i str =
                let len = String.length str in
                let rec aux j =
                        if j >= len then len else
                        if pred str.[j] then j else
                        aux (j + 1)
                in
                aux i
        ;;
end

let part_a pre mid post =
        let is_digit = function | '0'..'9' -> true | _ -> false in
        let length = String.length mid in
        let numbers str = List.generate (fun i ->
                let f = String.find_next is_digit i str in
                if f >= length then None else
                let l = String.find_next (fun c -> not (is_digit c)) f str in
                Some (f, l)) 0
                |> List.map (fun (f, l) ->
                        let num = String.sub str f (l - f) in
                        (f, l, Scanf.sscanf num "%d" Fun.id))
        in
        let above = numbers pre in
        let inline = numbers mid in
        let below = numbers post in
        let asterisk = Seq.fold_lefti
                (fun list i c -> if c = '*' then (i::list) else list) []
                (String.to_seq mid)
        in
        let gears i = List.filter_map (fun (f, l, n) ->
                        if f - 1 <= i && i < l + 1 then Some n else None) in
        let neighbours i = gears i above @ gears i below @ gears i inline in
        asterisk
        |> List.filter_map (fun i ->
                let n = neighbours i in
                if List.length n <> 2 then None else (
                Some (List.nth n 0 * List.nth n 1)))
        |> List.fold_left (+) 0
;;
let () =
        let filename = if Array.length Sys.argv > 1
                then Array.get Sys.argv 1 else "day3/example.txt" in
        let ch = open_in filename in
        let similar a = (String.make (String.length a) '.') in
        let rec add_lines ~pre:pre ~mid:mid sum =
                match In_channel.input_line ch with
                | Some line ->
                        add_lines ~pre:mid ~mid:line (sum + part_a pre mid line)
                | None -> if String.length mid == 0 then sum
                else (sum + part_a pre mid (similar mid))

        in
        let sum = match In_channel.input_line ch with
                | Some line -> add_lines ~pre:(similar line) ~mid:line 0
                | None -> 0
        in
        print_string "Sum : "; print_int sum; print_newline ();
        close_in ch;
        ()
