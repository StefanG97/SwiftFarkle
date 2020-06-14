import Foundation

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

func getInput() -> Int{
	let sel = Int(readLine(strippingNewline: true)!)!
	return sel
}

func showRules(){
	let path="/home/mastery0da/Swift/farkle/Rules.txt"
	do{
	    let contents = try String(contentsOfFile: path, encoding: .utf8)
	    print(contents)
	}
	catch let error as NSError {
	    print("Ooops! Something went wrong: \(error)")
	}
	system( " read -p'Press Enter to continue...' var " )
}

func showMenu(){
	system("clear")
	print("=================");
	print("Welcome to Farkle");
	print("=================");
	print("Maximize the console window for best results. \n");
	print("1) New Game");
	print("2) Show Rules");
	print("3) Quit \n");
	print("Please enter a selection: ");
}

func congratulate(player: Player){
	system("clear")
	print("=================");
	print(" CONGRATULATIONS ");
	print("=================");
	print(player.name, "is the winner with a score of", player.score, "points!");
	system( " read -p'Press Enter to continue...' var " )
}

func finalRound(player: Player){
	system("clear")
	print("=================");
	print("   FINAL ROUND   ");
	print("=================");
	print(player.name, "has a score of", player.score, "!");
	print("The final round of play has begun! Good luck! \n");
	system( " read -p'Press Enter to continue...' var " )
}

func showKeptDice(keptDice: [Int]){
	print("+------------+");
	print("| Kept Dices |");
	print("+------------+");
	for i in 0...keptDice.count - 1{
		switch i {
			case 0: print("|  ⚀   : ", keptDice[i], " |")
			case 1: print("|  ⚁   : ", keptDice[i], " |")
			case 2: print("|  ⚂   : ", keptDice[i], " |")
			case 3: print("|  ⚃   : ", keptDice[i], " |")
			case 4: print("|  ⚄   : ", keptDice[i], " |")
			case 5: print("|  ⚅   : ", keptDice[i], " |")
			default: print("Out of Bounds")
		}
	}
	print("+------------+\n");
}

func showRolls(dicePool: [Int], selection: Int, count: inout Int){
	print("+------------+");
	print("| Dice Rolls |");
	print("+------------+");

	for i in 0...dicePool.count - 1{
		if count == 0 || selection == 9{
			for _ in 0...7500{
				let temp: Int = Int.random(in: 1..<7)
				switch temp {
					case 1:
						usleep(75)
						print("|Die ", i + 1, " : ⚀ |", terminator: "")
						print("\r", terminator: "")
					case 2:
						usleep(75)
						print("|Die ", i + 1, " : ⚁ |", terminator: "")
						print("\r", terminator: "")
					case 3:
						usleep(75)
						print("|Die ", i + 1, " : ⚂ |", terminator: "")
						print("\r", terminator: "")
					case 4:
						usleep(75)
						print("|Die ", i + 1, " : ⚃ |", terminator: "")
						print("\r", terminator: "")
					case 5:
						usleep(75)
						print("|Die ", i + 1, " : ⚄ |", terminator: "")
						print("\r", terminator: "")
					case 6:
						usleep(75)
						print("|Die ", i + 1, " : ⚅ |", terminator: "")
						print("\r", terminator: "")
					default: print("error")	
				}
			}
		}
		switch dicePool[i]{
			case 1: print("|Die ", i + 1, " : ⚀ |")
			case 2: print("|Die ", i + 1, " : ⚁ |")
			case 3: print("|Die ", i + 1, " : ⚂ |")
			case 4: print("|Die ", i + 1, " : ⚃ |")
			case 5: print("|Die ", i + 1, " : ⚄ |")
			case 6: print("|Die ", i + 1, " : ⚅ |")
			default: print("error")
		}
	}
	count += 1
	print("+------------+\n");	
}

func welcomePlayers(players: [Player]){
	var playerNames: String = ""
	system("clear")
	print("==================");
	print("     WELCOME!     ");
	print("==================");
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
	print("Welcome", playerNames, "!\n")
	system( " read -p'Press Enter to continue...' var " )
}

func promptNumPlayers(){
	system("clear")
	print("==================");
	print("     NEW GAME     ");
	print("==================");
	print("How many players are there? ");
}

func setupPlayerNames(players: inout [Player], numOfPlayers: Int){
	system("clear")
	print("==================");
	print("   PLAYER NAMES   ");
	print("==================");
	for i in 1...numOfPlayers{
		print("Enter name for Player", i, "(no spaces):")
		let name: String = readLine()!
		var player: Player = Player()
		player.name = name
		players.append(player)
		print("")
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
	if score >= 1000{
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
			default: print("err")
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
			print("Invalid number of players. Must be more than 1.")
			print("Try again: ")
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
		turnScore = turn(player: players[playerTurn])
		if !players[playerTurn].inGame && turnScore >= 0{
			players[playerTurn].setInGame()
		}
		if turnScore > 0{
			players[playerTurn].score += turnScore
		}
		if firstTo10K == -1 && checkFor10K(score: players[playerTurn].score){
			finalRound(player: players[playerTurn])
			firstTo10K = playerTurn
		}
		playerTurn += 1
	}
	return winner
}

func turn(player: Player) -> Int{
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
			print("=================");
			print(player.name, "'s Turn!");
			print("=================");
			print(player.name, "'s Score:", player.score);
			print("Turn Score:", turnScore);
			showRolls(dicePool: dicePool, selection: selection, count: &temp);
			temp += 1;

			showKeptDice(keptDice: keptDice)
			diceCount = countDice(dicePool: dicePool)
			
			if !scoringDice(diceCount: diceCount) && !canReroll{
				farkle = true
				selection = 0
				continue
			}

			print("Enter the die # you wish to keep. Triple values will automatically be kept.");
			print("Enter 9 to reroll dice or 0 to end your turn.");
			print("Selection: ");
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
				print("==================");
				print("   INVALID MOVE   ");
				print("==================");
				if selection == 0{
					print(player.name, "cannot score out at this time!")
				}
				else{
					print(player.name, "cannot reroll at this time!")
				}
				selection = 7
				system( " read -p'Press Enter to continue...' var " )
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
	print("=================");
	print(player.name, "'s TURN ENDS!")
	print("=================");
	if farkle{
		print(player.name, "HAS FARKLED!")
	}
	else{
		print(player.name, "has scored", turnScore, "points this turn!")
	}
	system( " read -p'Press Enter to continue...' var " )
	if farkle{
		return 0;
	}
	return turnScore;
}

func gameLoop(){
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
				print("===================");
				print("     QUESTION?     ");
				print("===================\n");
				print("Do you want to go back to the main menu? Yes/No?")
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
			default: print("Invalid Seleciton")
		}
	}
}

gameLoop()