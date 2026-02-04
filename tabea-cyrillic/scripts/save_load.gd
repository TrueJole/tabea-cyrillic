extends Node

const FILENAME: String = "user://savefile.json"
const QUESTION_FILENAME: String = "user://questions.json"

var savegame: Array[int]
var questions: Array#[Dictionary]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# load questions
	var file: FileAccess = FileAccess.open(QUESTION_FILENAME, FileAccess.READ)
	if FileAccess.file_exists(QUESTION_FILENAME):
		print(JSON.to_native(JSON.parse_string(file.get_as_text())))
		questions = JSON.to_native(JSON.parse_string(file.get_as_text()))
		Constants.NUMBER_QUESTIONS = questions.size()
		print("Loaded questions")
	else:
		questions = preload("res://assets/letters.json").data
		Constants.NUMBER_QUESTIONS = questions.size()
		print("Default questions")
	
	# load savegame
	file = FileAccess.open(FILENAME, FileAccess.READ)
	if FileAccess.file_exists(FILENAME):
		print(JSON.to_native(JSON.parse_string(file.get_as_text())))
		savegame = JSON.to_native(JSON.parse_string(file.get_as_text()))
		if savegame.size() != Constants.NUMBER_QUESTIONS:
			print("Loaded savegame, but does not match questions")
			resetSavegame()
	else:
		print("No savefile found")
		resetSavegame()

func resetSavegame() -> void:
	print("Resetting savegame")
	savegame = []
	Constants.NUMBER_QUESTIONS = questions.size()
	savegame.resize(Constants.NUMBER_QUESTIONS)

func writeQuestions() -> void:
	var file: FileAccess = FileAccess.open(QUESTION_FILENAME, FileAccess.WRITE)
	file.store_string(JSON.stringify(JSON.from_native(questions)))
	print("Writing questions")

func writeSavegame() -> void:
	var file: FileAccess = FileAccess.open(FILENAME, FileAccess.WRITE)
	file.store_string(JSON.stringify(JSON.from_native(savegame)))
	print("Writing savegame")
