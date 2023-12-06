type rgb = {red : int; green : int; blue : int}
;;
let read_rgb line =
        let values = String.split_on_char ',' line in
        values
        |> List.fold_left (fun rgb str ->
                Scanf.sscanf str " %d %s" (fun num typ ->
                        match typ with
                        | "red" -> {rgb with red = num }
                        | "green" -> {rgb with green = num }
                        | "blue" -> {rgb with blue = num }
                        | _ -> rgb
                )
        )
        {red=0; green=0; blue=0}
;;

let majorize {red; green; blue} limit =
        {red = max red limit.red;
        green = max green limit.green;
        blue = max blue limit.blue}
;;
let result_b line =
        let (id, off) = Scanf.sscanf line
                "Game %d : %n" (fun id off -> (id, off)) in
        let values = String.split_on_char ';'
                (String.sub line off (String.length line - off)) in
        values |>  List.map read_rgb |> List.fold_left majorize
        {red=0; green=0; blue=0} |> function {red; green; blue} ->
        red * green * blue

;;
let () =
        let filename = if Array.length Sys.argv > 1
                then Array.get Sys.argv 1 else "day2/example.txt" in
        let ch = open_in filename in
        let rec add_lines sum =
                match In_channel.input_line ch with
                | Some line -> add_lines (sum + result_b line)
                | None -> sum
        in
        print_string "Sum : ";
        print_int (add_lines 0);
        print_newline ();
        close_in ch;
        ()
