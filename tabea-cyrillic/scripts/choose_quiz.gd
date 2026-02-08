extends Control

const MAIN: PackedScene = preload("uid://b04vt18h530x3")
const QUIZBUTTON: PackedScene = preload("uid://yxe3xq01ans8")

#var CHOOSE_QUIZ.instantiate()): String
var next: String
var back: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(SaveLoad.quizzes.keys())
	for quizID: String in SaveLoad.quizzes.keys():
		
		var quiz_button: QuizButton = QUIZBUTTON.instantiate()
		quiz_button.quizID = quizID
		quiz_button.text = SaveLoad.quizzes[quizID]["name"]
		if next == "quiz" and SaveLoad.quizzes[quizID]["questions"].size() < 2:
			quiz_button.disabled = true
			Constants.selectedQuizzes.erase(quizID)
		
		if next == "quiz" and SaveLoad.quizzes[quizID]["questions"].size() >= 2 and quizID in Constants.selectedQuizzes:
			quiz_button.button_pressed = true
		else:
			quiz_button.button_pressed = false
		
		quiz_button.clicked_on.connect(_on_quiz_clicked_on)
		%QuizList.add_child(quiz_button)

func _process(delta: float) -> void:
	if Constants.selectedQuizzes.size() < 1:
		%DoneButton.disabled = true
	else:
		%DoneButton.disabled = false

func _on_quiz_clicked_on(quizID: String, on: bool) -> void:
	if on and not quizID in Constants.selectedQuizzes: 
		Constants.selectedQuizzes.append(quizID)
	else:
		Constants.selectedQuizzes.erase(quizID)

func _on_all_button_pressed() -> void:
	var safeQuizIDs: Array = SaveLoad.quizzes.keys()
	safeQuizIDs = safeQuizIDs.filter(func(quizID: String) -> bool: return SaveLoad.quizzes[quizID]["questions"].size() >= 2)
	if safeQuizIDs.size() >= 1:
		Constants.selectedQuizzes = safeQuizIDs
		_on_done_button_pressed()


func _on_header_logo_clicked() -> void:
	var MAINMENU: PackedScene = load("uid://cj28jotdlpd0g")
	add_sibling(MAINMENU.instantiate())
	queue_free()


func _on_done_button_pressed() -> void:
	SaveLoad.writeQuizzes()
	match next:
		"quiz":
			add_sibling(MAIN.instantiate())
			queue_free()
