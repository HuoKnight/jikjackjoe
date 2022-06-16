function printBoard()
    println("    1     2     3   \n", join(field['A'][1]), join(field['A'][2]), join(field['A'][3]), "\n", join(field['B'][1]), join(field['B'][2]), join(field['B'][3]), "\n", join(field['C'][1]), join(field['C'][2]), join(field['C'][3]), "\n")
end

function updateBoardState(cell, char)
    push!(boardState[cell], char)
end



field = Dict('A' => [["       |", "\n", "A   -  |", "\n", "  _____|", "\u001b[2A"], 
                    ["     |", "\n\u001b[8C", "  -  |", "\n\u001b[8C", "_____|", "\u001b[2A"], 
                    ["     ", "\n\u001b[14C", "  -  ", "\n\u001b[14C", "_____"]],
            'B' => [["       |", "\n", "B   -  |", "\n", "  _____|", "\u001b[2A"],
                    ["     |", "\n\u001b[8C", "  -  |", "\n\u001b[8C", "_____|", "\u001b[2A"],
                    ["     ", "\n\u001b[14C", "  -  ", "\n\u001b[14C", "_____"]],
            'C' => [
                    ["       |", "\n", "C   -  |", "\n", "       |", "\u001b[2A"],
                    ["     |", "\n\u001b[8C", "  -  |", "\n\u001b[8C", "     |", "\u001b[2A"],
                    ["     ", "\n\u001b[14C", "  -  ", "\n\u001b[14C", "     "]]
)
usedCells = []
boardState = Dict("A1" => [], "A2" => [], "A3" => [], "B1" => [], "B2" => [], "B3" => [], "C1" => [], "C2" => [], "C3" => [],)

winCon = false
turnChar = "O"
for turn in range(1, 9)
    printBoard()
    print("\u001b[2kInput Board Position: ")
    cursorPOS = "\e"
    @label input_err
    POS = readline()
    POS = uppercase(POS[1]) * POS[2]
    if match(r"A|B|C", "$(POS[1])") != nothing && match(r"1|2|3", "$(POS[2])") != nothing && !(POS in usedCells)
        push!(usedCells, POS)
        print("\u001b[12A")
        field[POS[1]][parse(Int64, POS[2])][3] = replace(field[POS[1]][parse(Int64, POS[2])][3], "-" => "$turnChar")
    else
        print("")
        @goto input_err
    end
    updateBoardState(POS, turnChar)
    if turnChar == "O"
        global turnChar = "X"
    else
        global turnChar = "O"
    end
    print(boardState)
end


