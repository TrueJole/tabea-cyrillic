extends Control
const PRONOUNCIATION_LABEL: PackedScene = preload("uid://dbcqiv2obxa3t")
var MENU: PackedScene = load("uid://cj28jotdlpd0g")

var currentQuestionID: int
var lastQuestionID: int = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	newGuess()
	
func newGuess() -> void:
	SaveLoad.writeSavegame()
	%Answers.hide()
	for label: Label in %Answers.get_children():
		label.free()
	%RevealButton.show()
	%EvaluationButtons.hide()
	
	lastQuestionID = currentQuestionID
	
	# Choose a random ID based on the weights
	var totalSum: float = 0
	for i: int in SaveLoad.savegame:
		totalSum += pow(2, i)
	
	# Repeat until replacement
	while true:
		var randomPicker: float = randf_range(0, totalSum)
		var currentSum: float = 0
		for x: int in range(Constants.NUMBER_QUESTIONS):
			if currentSum + pow(2, SaveLoad.savegame[x]) > randomPicker:
				currentQuestionID = x
				break
			currentSum += pow(2, SaveLoad.savegame[x])
		
		if currentQuestionID != lastQuestionID:
			break
	
	%LetterLabel.text = SaveLoad.questions[currentQuestionID]["question"]
	%LetterLabel.autoadjust()
	for answer: String in SaveLoad.questions[currentQuestionID]["answers"]:
		var label: Label = PRONOUNCIATION_LABEL.instantiate()
		label.text = answer
		%Answers.add_child(label)
	
	print("Done!")

func _on_reveal_button_pressed() -> void:
	%RevealButton.hide()
	%Answers.show()
	%EvaluationButtons.show()

func _on_right_button_pressed() -> void:
	SaveLoad.savegame[currentQuestionID] -= 1
	newGuess()

func _on_wrong_button_pressed() -> void:
	SaveLoad.savegame[currentQuestionID] += 1
	newGuess()
	
func _on_logo_button_pressed() -> void:
	add_sibling(MENU.instantiate())
	queue_free()
