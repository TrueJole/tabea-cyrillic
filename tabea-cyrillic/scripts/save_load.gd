extends Node

const FILENAME: String = "user://savegames.json"
const QUESTION_FILENAME: String = "user://questions.json"
const QUIZ_FILENAME: String = "user://quizzes.json"

var savegame: Dictionary
#var questions: Array#[Dictionary]
var quizzes: Dictionary # Array of Dictionary of Array


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# load questions
	var file: FileAccess = FileAccess.open(QUIZ_FILENAME, FileAccess.READ)
	if FileAccess.file_exists(QUIZ_FILENAME):
		print(JSON.to_native(JSON.parse_string(file.get_as_text())))
		quizzes = JSON.to_native(JSON.parse_string(file.get_as_text()))
		#Constants.NUMBER_QUESTIONS = questions.size()
		print("Loaded questions")
	else:
		quizzes = { "abc123" : preload("res://assets/letters.json").data}
		#Constants.NUMBER_QUESTIONS = questions.size()
		print("Default questions")
	
	# load savegame
	file = FileAccess.open(FILENAME, FileAccess.READ)
	if FileAccess.file_exists(FILENAME):
		print(JSON.to_native(JSON.parse_string(file.get_as_text())))
		savegame = JSON.to_native(JSON.parse_string(file.get_as_text()))
		#if savegame.size() != Constants.NUMBER_QUESTIONS:
		#	print("Loaded savegame, but does not match questions")
		#	resetSavegame()
	else:
		print("No savefile found")
		generateSavegames()
		#resetSavegame()

func generateSavegames() -> void:
	print("Generating savegame")
	savegame = {}
	for quizID: String in quizzes.keys():
		savegame[quizID] = []
		savegame[quizID].resize(quizzes[quizID]["questions"].size())
		savegame[quizID].fill(0)
	writeSavegame()

func resetSavegameQuiz(quizID: String) -> void:
	print("Resetting savegame")
	savegame[quizID] = []
	#Constants.NUMBER_QUESTIONS = questions.size()
	savegame[quizID].resize(quizzes[quizID]["questions"].size())
	savegame[quizID].fill(0)
	writeSavegame()

#func writeQuestions() -> void:
	#var file: FileAccess = FileAccess.open(QUESTION_FILENAME, FileAccess.WRITE)
	#file.store_string(JSON.stringify(JSON.from_native(questions)))
	#print("Writing questions")

func writeQuizzes() -> void:
	var file: FileAccess = FileAccess.open(QUIZ_FILENAME, FileAccess.WRITE)
	file.store_string(JSON.stringify(JSON.from_native(quizzes)))
	print("Writing quizzes")

func writeSavegame() -> void:
	var file: FileAccess = FileAccess.open(FILENAME, FileAccess.WRITE)
	file.store_string(JSON.stringify(JSON.from_native(savegame)))
	print("Writing savegame")
