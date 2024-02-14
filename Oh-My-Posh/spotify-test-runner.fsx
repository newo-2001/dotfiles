#r "nuget: FSharp.Data"

open FSharp.Core
open FSharp.Data
open System.Text.RegularExpressions

let remixRegex = Regex(@".* (?:[-–] (?:(.*) )?(?:remix)|[(（［[](?:([^)\]）］]*) )?(?:remix)[)\]）］]).*", RegexOptions.IgnoreCase)
let artistRegex = Regex(@" ?([([（［]cv[.:] ?.+[)\]）］]|&.*)", RegexOptions.IgnoreCase)
let songRegex = Regex(@" ?((\[.*\]|\(.*\)|（.*）|［.*］|-.+-|–.+–|~.+~|～.+～)| [-–~～:|] ).*")

type ParsedSong = {
    artist: string;
    title: string;
    remix: bool;
}

let displaySong song =
    let seperator = if song.remix then '' else '-'
    $"{song.artist} {seperator} {song.title}"

type Test = {
    artist: string;
    title: string;
    expected: ParsedSong;
};

let runTest (test: Test) =
    let remix, artist =
        let matches = remixRegex.Match(test.title)

        let artist =
            if not matches.Success then test.artist
            else
                let captures =
                    seq { for group in matches.Groups do yield group }
                    |> Seq.tail
                    |> Seq.choose (fun group ->
                        seq { for capture in group.Captures do yield capture.Value }
                        |> Seq.tryLast
                    )
                
                if Seq.isEmpty captures then test.artist
                else String.concat "" captures
            |> fun artist -> artistRegex.Replace(artist, "")

        matches.Success, artist

    let title = songRegex.Replace(test.title, "")
    let actual = {
        artist = artist;
        title = title;
        remix = remix;
    }
    
    if actual = test.expected then Ok(())
    else Error(actual)

let parseBool str =
    match str with
    | "true" -> true
    | "false" -> false
    | _ -> failwith "Expected boolean"

let results =
    CsvFile.Load(__SOURCE_DIRECTORY__ + "/spotify-tests.csv").Rows
    |> Seq.map(fun row ->
        match row.Columns with
        | [| artist; title; expected; remix |] ->
            let parsed =
                match expected.Split(" - ") with
                | [| artist; title |] ->
                    {
                        artist = artist;
                        title = title;
                        remix = parseBool remix
                    }
                | _ -> failwith $"Invalid expected output: {expected}"
            {
                artist = artist;
                title = title;
                expected = parsed;
            }
        | _ -> failwith $"Invalid row in input: {row.ToString()}"
    )
    |> Seq.map (fun test -> (test, runTest test))
    |> Seq.toList

let totalTests = results.Length
let failedTests =
    results
    |> Seq.choose (fun (test, result) ->
        match result with
        | Ok(()) -> None
        | Error(displayed) -> Some(test, displayed)
    )
    |> Seq.toList

for test, result in failedTests do
    printf "Test failed:\n\tInput: %s - %s\n\tExpected: %s\n\tGot: %s\n\n" test.artist test.title (displaySong test.expected) (displaySong result)

let passedTests = totalTests - failedTests.Length
printf "Summary: %i/%i tests passed\n" passedTests totalTests
