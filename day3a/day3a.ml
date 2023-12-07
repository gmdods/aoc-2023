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



let stencil ~limit:n seq i =
        (if i > 0 then seq (i - 1) else false)
        || seq i ||
        (if i + 1 < n then seq (i + 1) else false)
;;
let part_a pre mid post =
        let is_digit = function | '0'..'9' -> true | _ -> false in
        let is_symbol c = (c <> '.') && not (is_digit c) in
        let lookahead i = is_symbol pre.[i] || is_symbol post.[i] in
        let length = String.length mid in
        let neighbour = stencil ~limit:length lookahead in
        let sideway = stencil ~limit:length (fun i -> is_symbol mid.[i]) in
        let rec is_part f l =
                if f >= l then false else
                if neighbour f || sideway f then true else
                is_part (f + 1) l
        in
        List.generate (fun i ->
                let f = String.find_next is_digit i mid in
                if f >= length then None else
                let l = String.find_next (fun c -> not (is_digit c)) f mid in
                Some (f, l)) 0
        |> List.filter_map (fun (f, l) ->
                if not (is_part f l) then None else
                let str = String.sub mid f (l - f) in
                Some (Scanf.sscanf str "%d" Fun.id))
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
