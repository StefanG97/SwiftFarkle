import Foundation
import Rainbow

extension String {
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}

struct Player{
	var name: String
	var score: Int
	var inGame: Bool

	init(){
		self.name = ""
		self.score = 0
		self.inGame = false
	}

	mutating func copy(name: String, score: Int, inGame: Bool){
		self.name = name
		self.score = score
		self.inGame = inGame
	}

	mutating func setInGame(){
		self.inGame = true
	}
}

func systemPause(){
	print("    Press any key to continue...".white.bold, terminator: "")
	let _ = readLine(strippingNewline: true)!
}

func getInput() -> Int{
	let input: String = readLine(strippingNewline: true)!
	if input.isNumeric{
		return Int(input)!
	}
	else{
		return 7
	}
}

func showRules(){
	let path = FileManager.default.currentDirectoryPath + "/Rules.txt"
	do{
	    let contents = try String(contentsOfFile: path, encoding: .utf8)
	    print(contents.bold)
	}
	catch let error as NSError {
	    print("    Ooops! Something went wrong: \(error)")
	}
	systemPause()
}


func showMenu(){
	system("clear")
	print("\u{001B}[?25h", terminator: "") 
	print("    =======================".white.bold)
	print("       Welcome to Farkle   ".green.bold)
	print("    =======================\n".red.bold)
	print("    Maximize the console window for best results. \n".bold.blink)
	print("    1) New Game".green.bold)
	print("    2) Show Rules".yellow.bold)
	print("    3) Quit\n".red.bold)
	print("    Please enter a selection: ".bold, terminator: "")
}

func congratulate(player: Player){
	system("clear")
	print("\u{001B}[?25h", terminator: "") 
	print("    =======================".white.bold)
	print("        CONGRATULATIONS    ".green.bold.blink)
	print("    =======================\n".red.bold)
	print("    \(player.name) is the winner with a score of \(player.score) points!\n".lightMagenta.bold)
	systemPause()
}

func finalRound(player: Player, players: [Player]){
	system("clear")
	print("\u{001B}[?25l", terminator: "")  
	print("    =======================".white.bold)
	print("          FINAL ROUND      ".green.bold.blink)
	print("    =======================\n".red.bold)
	print("    \(player.name) has a score of \(player.score)!\n".lightMagenta.bold.blink)
	sleep(5)
	system("clear")
	print("    =======================".white)
	showScoreboard(players: players)
	print("\n    The final round of play has begun! Good luck! \n".lightGreen.bold)
	systemPause()
	print("\u{001B}[?25h", terminator: "")
}

func showScoreboard(players: [Player]){
	print("          LEADERBOARD       ".green.bold)
	print("    ========================".red.bold)
	var tempPlayers: [Player] = players
	tempPlayers.sort { (lhs: Player, rhs: Player) -> Bool in
	    return lhs.score > rhs.score
	}
	for i in 0...players.count - 1{
		print("    \(i+1). \(tempPlayers[i].name) : \(tempPlayers[i].score) points".bold)
	}
}

func showKeptDice(keptDice: [Int]){
	print("\u{001B}[?25h", terminator: "") 
	print("    +----------------------+".lightGreen.bold)
	print("    |      Kept Dices      |".lightGreen.bold)
	print("    +----------------------+".lightGreen.bold)
	for i in 0...keptDice.count - 1{
		switch i {
			case 0: print("    |     ⚀     :    \(keptDice[i])     |".red.bold)
			case 1: print("    |     ⚁     :    \(keptDice[i])     |".lightBlack.bold)
			case 2: print("    |     ⚂     :    \(keptDice[i])     |".lightGreen.bold)
			case 3: print("    |     ⚃     :    \(keptDice[i])     |".yellow.bold)
			case 4: print("    |     ⚄     :    \(keptDice[i])     |".magenta.bold)
			case 5: print("    |     ⚅     :    \(keptDice[i])     |".cyan.bold)
			default: print("    Out of Bounds")
		}
	}
	print("    +----------------------+\n".lightGreen.bold)
}

func showRolls(dicePool: [Int], selection: Int, count: inout Int){
	print("    +----------------------+".lightBlue.bold)
	print("    |      Dice Rolls      |".lightBlue.bold)
	print("    +----------------------+".lightBlue.bold)
	print("\u{001B}[?25l", terminator: "") 
	for i in 0...dicePool.count - 1{
		if count == 0 || selection == 9{
			for _ in 0...7500{
				let temp: Int = Int.random(in: 1..<7)
				switch temp {
					case 1:
						usleep(50)
						print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚀".red.bold,"    |".lightBlue.bold, terminator: "")
						print("\r", terminator: "")
					case 2:
						usleep(50)
						print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚁".lightBlack.bold,"    |".lightBlue.bold, terminator: "")
						print("\r", terminator: "")
					case 3:
						usleep(50)
						print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚂".lightGreen.bold,"    |".lightBlue.bold, terminator: "")
						print("\r", terminator: "")
					case 4:
						usleep(50)
						print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚃".yellow.bold,"    |".lightBlue.bold, terminator: "")
						print("    \r", terminator: "")
					case 5:
						usleep(50)
						print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚄".magenta.bold,"    |".lightBlue.bold, terminator: "")
						print("\r", terminator: "")
					case 6:
						usleep(50)
						print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚅".cyan.bold,"    |".lightBlue.bold, terminator: "")
						print("\r", terminator: "")
					default: print("    error")	
				}
			}
		}
		switch dicePool[i]{
			case 1: print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚀".red.bold, "    |".lightBlue.bold)
			case 2: print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚁".lightBlack.bold, "    |".lightBlue.bold)
			case 3: print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚂".lightGreen.bold, "    |".lightBlue.bold)
			case 4: print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚃".yellow.bold, "    |".lightBlue.bold)
			case 5: print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚄".magenta.bold, "    |".lightBlue.bold)
			case 6: print("    |    Die \(i + 1)   :  ".lightBlue.bold, "⚅".cyan.bold, "    |".lightBlue.bold)
			default: print("    error")
		}
	}
	print("\u{001B}[?25h", terminator: "") 
	count += 1
	print("    +----------------------+\n".lightBlue.bold)	
}

func welcomePlayers(players: [Player]){
	var playerNames: String = ""
	system("clear")
	print("\u{001B}[?25h", terminator: "") 
	print("    ========================".white.bold)
	print("             WELCOME        ".green.bold.blink)
	print("    ========================\n".red.bold)
	for i in 0...players.count - 1{
		if i < (players.count - 2) && players.count > 2{
			playerNames.append(players[i].name)
			playerNames.append(", ")
		}
		else if i == players.count - 1{
			playerNames.append(" and ")
			playerNames.append(players[i].name)
		}
		else{
			playerNames.append(players[i].name)
		}
	}
	print("    Welcome \(playerNames)!\n".magenta.bold)
	systemPause()
}

func promptNumPlayers(){
	system("clear")
	print("\u{001B}[?25h", terminator: "") 
	print("    =======================".white.bold)
	print("           NEW GAME        ".green.bold.blink)
	print("    =======================\n".red.bold)
	print("    How many players are there? ", terminator: "".lightYellow.bold)
}

func setupPlayerNames(players: inout [Player], numOfPlayers: Int){
	system("clear")
	print("\u{001B}[?25h", terminator: "") 
	print("    ========================".white.bold)
	print("          PLAYER NAMES      ".green.bold.blink)
	print("    ========================\n".red.bold)
	for i in 1...numOfPlayers{
		print("    Enter name for Player \(i) (no spaces): ".lightGreen.bold, terminator: "")
		let name: String = readLine()!
		var player: Player = Player()
		player.name = name
		players.append(player)
	}
}

func countDice(dicePool: [Int]) -> [Int]{
	var counter = Array<Int>(repeating: 0, count: 6)
	for i in 0...dicePool.count - 1{
		counter[dicePool[i] - 1] += 1
	}
	return counter
}

func checkFor10K(score: Int) -> Bool{
	if score >= 10000{
		return true
	}
	return false
}

func scoringDice(diceCount: [Int]) -> Bool{
	var i: Int = 1
	if diceCount[0] >= 1 || diceCount[4] >= 1{
		return true
	}
	while i != diceCount.count{
		if i == 4{
			i = 5
		}
		if diceCount[i] >= 3{
			return true
		}
		i += 1
	}
	return false
}

func isValid(selection: Int, dicePool: [Int]) -> Bool{
	if selection > 0 && selection <= dicePool.count{
		return true
	}
	return false
}

func scoreDice(dicePool: inout [Int], die: Int, dieCount: [Int], keptDice: inout [Int]) -> Int{
	let index = die - 1
	var score: Int = 0
	let dieValue: Int = dicePool[index]
	if dieCount[(dieValue - 1)] >= 3{
		var i: Int = 0
		var j: Int = dicePool.count - 1
		while i < 3{
			for _ in 0...dicePool.count - 1{
				if dicePool[j] == dieValue{
					dicePool.remove(at: j)
					keptDice[dieValue - 1] += 1
					i += 1
				}
				j -= 1
			}
		}
		switch i {
			case 3:
				if dieValue == 1{
					score = 1000
				}
				else{
					score = dieValue * 100
				}
			case 4:
				if dieValue == 1{
					score = 2000
				}
				else{
					score = dieValue * 200
				}
			case 5:
				if dieValue == 1{
					score = 4000
				}
				else{
					score = dieValue * 400
				}
			case 6:
				if dieValue == 1{
					score = 8000
				}
				else{
					score = dieValue * 800
				}
			default: print("    err")
		}
	}
	else if dieValue == 1 || dieValue == 5{
		dicePool.remove(at: index)
		keptDice[(dieValue - 1)] += 1
		
		score = dieValue == 1 ? 100 : 50
	}
	return score
}

func rollDice(dicePool: inout [Int]){
	for i in 0...dicePool.count - 1{
		dicePool[i] = Int.random(in: 1..<7)
	}
}

func getWinner(players: [Player]) -> Player{
	var winner: Player = Player()
	winner.copy(name: players[0].name, score: players[0].score, inGame: players[0].inGame)
	print(winner.name, winner.score)
	var i: Int = 1
	while i != players.count{
		if players[i].score > players[i - 1].score{
			winner.copy(name: players[i].name, score: players[i].score, inGame: players[i].inGame)
		}
		i += 1
	}
	return winner
}

func play() -> Player{
	var winner: Player = Player()
	var numOfPlayers: Int = 0
	var playerTurn: Int = 0
	var firstTo10K: Int = -1
	var turnScore: Int
	promptNumPlayers()
	while !(numOfPlayers > 1){
		numOfPlayers = getInput()
		if numOfPlayers < 2{
			print("\u{001B}[?25h", terminator: "") 
			print("    Invalid number of players. Must be more than 1.".lightRed.bold)
			print("    Try again: ".lightRed.bold)
		}
	}
	var players: [Player] = []
	setupPlayerNames(players: &players, numOfPlayers: numOfPlayers)
	welcomePlayers(players: players)
	while winner.name.isEmpty{
		if playerTurn == players.count{
			playerTurn = 0
		}
		if firstTo10K >= 0 && playerTurn == firstTo10K{
			winner = getWinner(players: players)
			continue
		}
		turnScore = turn(player: players[playerTurn], players: players)
		if !players[playerTurn].inGame && turnScore >= 0{
			players[playerTurn].setInGame()
		}
		if turnScore > 0{
			players[playerTurn].score += turnScore
		}
		if firstTo10K == -1 && checkFor10K(score: players[playerTurn].score){
			finalRound(player: players[playerTurn], players: players)
			firstTo10K = playerTurn
		}
		playerTurn += 1
	}
	return winner
}

func turn(player: Player, players: [Player]) -> Int{
	var dicePool: [Int] = []
	var keptDice: [Int] = []
	var diceCount: [Int] = []
	var turnScore: Int = 0
	var farkle: Bool = false
	var canPass: Bool
	var canReroll: Bool
	var hasPassed: Bool = false
	var selection: Int = 0
	var temp: Int = 0

	for _ in 0...5{
		keptDice.append(0)
		diceCount.append(0)
	}

	while !hasPassed{
		if dicePool.count == 0 || dicePool.isEmpty{
			for _ in 0...5{
				dicePool.append(1)
			}
		}

		rollDice(dicePool: &dicePool)
		canReroll = false
		canPass = false
		repeat{
			system("clear")
			print("\u{001B}[?25h", terminator: "") 
			print("    ========================".white.bold)
			showScoreboard(players: players)
			print("    ========================".lightBlack.bold)
			let chars: Int = (16 - player.name.count) / 2
			var centeredName: String = "    "
			if chars > 0{
				for _ in 0...chars{
					centeredName += " "
				}
				centeredName += player.name
				centeredName += "'s Turn!"
				print(centeredName.blue.blink.bold)
			}
			else{
				print("    \(player.name)'s Turn!")
			}
			print("    ========================".red.bold)
			let stringScore: String = String(turnScore)
			var centeredTurn: String = "    "
			let turnChars: Int = (5 - stringScore.count) / 2
			if turnChars > 0{
				for _ in 0...turnChars{
					centeredTurn += " "
				}
				centeredTurn += "Turn Score: "
				centeredTurn += stringScore
				centeredTurn += " points"
				print(centeredTurn.lightGreen.bold)
			}
			else{
				print("    Turn Score: \(turnScore) points".lightGreen.bold);
			}
			centeredTurn = "    "
			showRolls(dicePool: dicePool, selection: selection, count: &temp)
			temp += 1

			showKeptDice(keptDice: keptDice)
			diceCount = countDice(dicePool: dicePool)
			
			if !scoringDice(diceCount: diceCount) && !canReroll{
				farkle = true
				selection = 0
				continue
			}
			print("\u{001B}[?25h", terminator: "") 
			print("    Enter the die # you wish to keep. Triple values will automatically be kept.")
			print("    Enter 9 to reroll dice or 0 to end your turn.")
			print("    Selection: ", terminator: "")
			selection = getInput()
			if isValid(selection: selection, dicePool: dicePool){
				turnScore += scoreDice(dicePool: &dicePool, die: selection, dieCount: diceCount, keptDice: &keptDice)
				canReroll = true
				if player.inGame || turnScore >= 0{
					canPass = true
				}
				else{
					canPass = false
				}
			}
			else if (selection == 0 && !canPass) || (selection == 9 && !canReroll){
				system("clear")
				print("\u{001B}[?25h", terminator: "") 
				print("    ========================".red.bold)
				print("          INVALID MOVE      ".red.bold.blink)
				print("    ========================\n".red.bold)
				if selection == 0{
					print("    \(player.name) cannot score out at this time!".red.bold)
				}
				else{
					print("    \(player.name) cannot reroll at this time!".red.bold)
				}
				selection = 7
				systemPause()
			}
			if dicePool.isEmpty{
				selection = 9
			}
		}while (selection != 9 && selection > 0)
		if selection == 0{
			hasPassed = true
		}
		else{
			hasPassed = false
		}
	}
	system("clear")
	print("\u{001B}[?25h", terminator: "") 
	if farkle{
		print("    =======================".red.bold)
		print("    \(player.name)'s TURN ENDS!".red.bold.blink)
		print("    =======================".red.bold)
		print("    \(player.name) HAS FARKLED!".red.bold)
	}
	else{
		print("    =======================".lightGreen.bold)
		print("    \(player.name)'s TURN ENDS!".lightGreen.bold.blink)
		print("    =======================".lightGreen.bold)
		print("    \(player.name) has scored \(turnScore) points this turn!".lightGreen.bold)
	}
	systemPause()
	if farkle{
		return 0
	}
	return turnScore
}

func gameLoop(){
	print("\u{001B}[18m", terminator: "")
	var selection: Int
	var winner: Player = Player()
	while true{
		showMenu()
		selection = getInput()
		switch selection {
			case 1:
				winner = play()
				congratulate(player: winner)
				system("clear")
				print("\u{001B}[?25h", terminator: "") 
				print("    =========================".white.bold)
				print("            QUESTION?        ".green.bold.blink)
				print("    =========================\n".red.bold)
				print("    Do you want to go back to the main menu? Yes/No?", terminator: "".lightMagenta.bold)
				let answer: String = readLine()!
				if answer == "Yes" || answer == "yes" || answer == "y" || answer == "Y"{
					gameLoop()
				}
				else{
					exit(0)
				}
			case 2:
				system("clear")
				showRules()
			case 3: exit(0)
			default: print("    Invalid Seleciton")
		}
		print("\u{001B}[?25h", terminator: "") 
	}
}

gameLoop()