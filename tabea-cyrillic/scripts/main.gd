extends Control
const PRONOUNCIATION_LABEL: PackedScene = preload("uid://dbcqiv2obxa3t")
var MENU: PackedScene = load("uid://cj28jotdlpd0g")

var currentQuestionID: int
var currentQuizID: String
var lastQuestionID: int = -1
var lastQuizID: String = "-9999999"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	newGuess()
	
func newGuess() -> void:
	print(Constants.selectedQuizzes)
	print(currentQuizID)
	SaveLoad.writeSavegame()
	%Answers.hide()
	for label: Label in %Answers.get_children():
		label.free()
	%RevealButton.show()
	%EvaluationButtons.hide()
	
	lastQuestionID = currentQuestionID
	lastQuizID = currentQuizID
	
	# Choose a random ID based on the weights
	var totalSum: float = 0
	for quizID: String in Constants.selectedQuizzes:
		print(SaveLoad.savegame)
		for i: int in SaveLoad.savegame[quizID]:
			totalSum += pow(2, i)
	
	# Repeat until replacement
	while true:
		var randomPicker: float = randf_range(0, totalSum)
		var currentSum: float = 0
		var break_condition: bool = false
		for quizID: String in Constants.selectedQuizzes:
			for x: int in range(SaveLoad.savegame[quizID].size()):
				if currentSum + pow(2, SaveLoad.savegame[quizID][x]) > randomPicker:
					currentQuestionID = x
					currentQuizID = quizID
					break_condition = true
					break
				currentSum += pow(2, SaveLoad.savegame[quizID][x])
			if break_condition:
				break
		if currentQuestionID != lastQuestionID or currentQuizID != lastQuizID:
			break
	
	%LetterLabel.text = SaveLoad.quizzes[currentQuizID]["questions"][currentQuestionID]["question"]
	%LetterLabel.autoadjust()
	for answer: String in SaveLoad.quizzes[currentQuizID]["questions"][currentQuestionID]["answers"]:
		var label: Label = PRONOUNCIATION_LABEL.instantiate()
		label.text = answer
		%Answers.add_child(label)
	
	print("Done!")

func _on_reveal_button_pressed() -> void:
	%RevealButton.hide()
	%Answers.show()
	%EvaluationButtons.show()

func _on_right_button_pressed() -> void:
	SaveLoad.savegame[currentQuizID][currentQuestionID] -= 1
	newGuess()

func _on_wrong_button_pressed() -> void:
	SaveLoad.savegame[currentQuizID][currentQuestionID] += 1
	newGuess()
	
func _on_header_logo_clicked() -> void:
	add_sibling(MENU.instantiate())
	queue_free()
