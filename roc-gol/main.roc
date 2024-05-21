app [main] {
    pf: platform "https://github.com/roc-lang/basic-cli/releases/download/0.10.0/vNe6s9hWzoTZtFmNkvEICPErI9ptji_ySjicO6CkucY.tar.br",
    ansi: "https://github.com/lukewilliamboswell/roc-ansi/releases/download/0.5/1JOFFXrqOrdoINq6C4OJ8k3UK0TJhgITLbcOb-6WMwY.tar.br",
}

import pf.Stdout
import pf.Stdin
import pf.Task exposing [Task]
import pf.Sleep
import pf.Tty
import ansi.Core

iterations = 10

ScreenInfo : { cursor : Core.Position, screen : Core.ScreenSize }

main =
    Tty.enableRawMode!
    # Enter alternate terminal buffer
    Stdout.write! "\u(001b)[?1049h"
    terminalSize = getTerminalSize!
    screenInfo = { cursor: { row: 0, col: 0 }, screen: terminalSize }
    _ = Task.loop! 1 (\n -> gameLoop screenInfo iterations n)
    # Exit alternate terminal buffer
    Stdout.write! "\u(001b)[?1049l"
    Tty.disableRawMode!
    Task.ok {}

getTerminalSize : Task.Task Core.ScreenSize _
getTerminalSize =

    # Move the cursor to bottom right corner of terminal
    cmd =
        [MoveCursor (To { row: 999, col: 999 }), GetCursor]
        |> List.map Control
        |> List.map Core.toStr
        |> Str.joinWith ""
    Stdout.write! cmd
    # Read the cursor position
    Stdin.bytes
        |> Task.map Core.parseCursor
        |> Task.map! \{ row, col } -> { width: col, height: row }

gameLoop : ScreenInfo, Num _, Num _ -> Task.Task _ _
gameLoop = \screenInfo, numRepeats, current ->
    maybeN =
        when current is
            _ if current >= numRepeats -> Nothing
            1 -> Just "1st"
            2 -> Just "2nd"
            3 -> Just "3rd"
            _ -> Just "$(Num.toStr current)th"

    drawLine = \txt ->
        Core.drawScreen screenInfo [Core.drawText txt { r: current, c: current }] |> Stdout.write!
        Sleep.millis! 100

    when maybeN is
        Just n ->
            drawLine! "Hello for the $(n) time!"
            Task.ok (Step (current + 1))

        Nothing ->
            drawLine! "Hello for the last time!"
            Task.ok (Done current)

