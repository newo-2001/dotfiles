open System.IO
open FSharp.Core
open System.Text.RegularExpressions

let remixRegex = Regex(@"(?:.+? )(?:[-–] (.+?) (?:[Rr]emix|REMIX)|[\(\[]([^\)\]]+?) (?:[Rr]emix|REMIX)[\)\]])(?:.*)")
let songRegex = Regex(@" ?[\[\(（［]([^\)\]）］]*)[\)\]）］]| [-–] .*$")
let artistRegex = Regex(@" ?[\(\[（［][Cc][Vv][\.:].+?[\)\]）］]")

type Test = {
    artist: string;
    title: string;
    expected: string;
};

let runTest (test: Test) =
    let artist: string =
        let matches = remixRegex.Match(test.title)

        if not matches.Success then test.artist
        else
            seq { for group in matches.Groups do yield group }
            |> Seq.tail
            |> Seq.choose (fun group ->
                seq { for capture in group.Captures do yield capture.Value }
                |> Seq.tryLast
            )
            |> Seq.reduce (fun x y -> $"{x}{y}")
        |> fun artist -> artistRegex.Replace(artist, "")

    let song = songRegex.Replace(test.title, "")
    let displayed = $"{artist} - {song}"
    
    if displayed = test.expected then Ok(())
    else Error(displayed)

let results =
    File.ReadLines(__SOURCE_DIRECTORY__ + "/spotify-tests.csv")
    |> Seq.tail
    |> Seq.map (fun line -> line.Split(','))
    |> Seq.map(fun columns ->
        match columns with
        | [| artist; title; expected |] ->
            {
                artist = artist;
                title = title;
                expected = expected;
            }
        | _ -> failwith "Invalid row in input"
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
    printf "Test failed:\n\tInput: %s - %s\n\tExpected: %s\n\tGot: %s\n\n" test.artist test.title test.expected result

let passedTests = totalTests - failedTests.Length
printf "Summary: %i/%i tests passed\n" passedTests totalTests