extends Control
const PRONOUNCIATION_LABEL = preload("uid://dbcqiv2obxa3t")

var letters : Array
#var randomIDs: Array
var currentLetterID: int
var lastLetterID: int = -1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	letters = preload("res://assets/letters.json").data
	newGuess()
	
func newGuess() -> void:
	SaveLoad.write()
	%Answers.hide()
	for label: Label in %Answers.get_children():
		label.free()
	%RevealButton.show()
	%EvaluationButtons.hide()
	
	lastLetterID = currentLetterID
	
	# Choose a random ID based on the weights
	var totalSum: float = 0
	for i: int in SaveLoad.data:
		totalSum += pow(2, i)
	
	# Repeat until replacement
	while true:
		var randomPicker: float = randf_range(0, totalSum)
		var currentSum: float = 0
		for x: int in range(SaveLoad.data.size()):
			if currentSum + pow(2, SaveLoad.data[x]) > randomPicker:
				currentLetterID = x
				break
			currentSum += pow(2, SaveLoad.data[x])
		
		if currentLetterID != lastLetterID:
			break
	
	%LetterLabel.text = letters[currentLetterID]["cyrillic-upper"] + "" + letters[currentLetterID]["cyrillic-lower"]
	for answer: String in letters[currentLetterID]["pronounciation"]:
		var label: Label = PRONOUNCIATION_LABEL.instantiate()
		label.text = answer
		%Answers.add_child(label)
	
	print("Done!")

func _on_reveal_button_pressed() -> void:
	%RevealButton.hide()
	%Answers.show()
	%EvaluationButtons.show()
	#%NextButton.text = "Next"

##DEPRECATED
func _on_next_button_pressed() -> void:
	newGuess()
	%NextButton.text = "Skip"


func _on_right_button_pressed() -> void:
	SaveLoad.data[currentLetterID] -= 1
	newGuess()


func _on_wrong_button_pressed() -> void:
	SaveLoad.data[currentLetterID] += 1
	newGuess()
	
