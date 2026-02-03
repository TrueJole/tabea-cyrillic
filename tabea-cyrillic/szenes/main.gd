extends Control
const PRONOUNCIATION_LABEL = preload("uid://dbcqiv2obxa3t")

var letters : Array
var randomIDs: Array
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	letters = preload("res://assets/letters.json").data
	newGuess()
	
func newGuess() -> void:
	if randomIDs.size() == 0:
		randomIDs = range(letters.size())
	%Answers.hide()
	for label: Label in %Answers.get_children():
		label.free()
	%RevealButton.show()
	
	var letterID: int = randomIDs.pick_random()
	randomIDs.erase(letterID)
	%LetterLabel.text = letters[letterID]["cyrillic-upper"] + "" + letters[letterID]["cyrillic-lower"]
	for answer: String in letters[letterID]["pronounciation"]:
		var label: Label = PRONOUNCIATION_LABEL.instantiate()
		label.text = answer
		%Answers.add_child(label)

func _on_reveal_button_pressed() -> void:
	%RevealButton.hide()
	%Answers.show()
	%NextButton.text = "Next"


func _on_next_button_pressed() -> void:
	newGuess()
	%NextButton.text = "Skip"
