extends Control

@onready var line_edit: LineEdit = $VBoxContainer/CenterContainer2/LineEdit
@onready var character: HippoSprite = $VBoxContainer/CenterContainer3/Control/HippoSprite


var character_name := ""
var character_preset := Enums.CharacterPreset.HUMAN


func _ready() -> void:
	line_edit.grab_focus()
	character.characterPreset = character_preset
	character.animation = Enums.PlayerAnimation.READY
	character.playAnimation()


func _on_line_edit_text_changed(new_text: String) -> void:
	character_name = line_edit.text
	var text_length = line_edit.text.length()
	var width = 420 if text_length == 0 else 64 + text_length * 24
	line_edit.custom_minimum_size = Vector2(width, 72)


func _on_line_edit_text_submitted(new_text: String) -> void:
	print("Hello, " + new_text)
