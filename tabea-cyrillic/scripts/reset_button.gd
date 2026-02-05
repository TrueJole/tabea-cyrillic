extends Button

func _on_pressed() -> void:
	SaveLoad.savegame = []
	SaveLoad.savegame.resize(Constants.NUMBER_QUESTIONS)
	SaveLoad.writeSavegame()
