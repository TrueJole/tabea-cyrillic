extends Button

func _on_pressed() -> void:
	SaveLoad.data = []
	SaveLoad.data.resize(Constants.ELEMENTS)
	SaveLoad.write()
