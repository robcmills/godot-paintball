extends Control

var hippo_player_scene = preload("res://scenes/hippo_player.tscn")

@onready var scroll_container: ScrollContainer = $VBoxContainer/ScrollContainer
@onready var container: HFlowContainer = $VBoxContainer/ScrollContainer/MarginContainer/HFlowContainer
@onready var select_tile: TileMapLayer = $VBoxContainer/ScrollContainer/MarginContainer/HFlowContainer/SelectTile

const animations = [
	Enums.PlayerAnimation.IDLE,
	Enums.PlayerAnimation.READY,
	Enums.PlayerAnimation.RUN,
]

var selected_preset := Enums.CharacterPreset.ASTRONAUT

func _ready() -> void:
	for preset in Enums.CharacterPreset.values():
		var control = Control.new()
		control.name = "CharacterControl"
		control.custom_minimum_size = Vector2i(250, 340)
		#control.focus_mode = Control.FOCUS_ALL
		container.add_child(control)
		
		var character = hippo_player_scene.instantiate()
		character.characterPreset = preset
		character.animation = animations.pick_random()
		character.scale = Vector2i(8, 8)
		character.position = Vector2i(100, 250)
		character.playAnimation()
		control.add_child(character)

func _process(_delta: float) -> void:
	for child in container.get_children():
		if child.get_class() != "Control":
			continue
		var character = child.get_child(0)
		if character.characterPreset == selected_preset:
			select_tile.position = child.position
			scroll_container.ensure_control_visible(child)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_right"):
		var new_preset = selected_preset + 1
		if new_preset >= Enums.CharacterPreset.size():
			new_preset = 0
		selected_preset = Enums.CharacterPreset.values()[new_preset]
	elif event.is_action_pressed("move_left"):
		var new_preset = selected_preset - 1
		if new_preset < 0:
			new_preset = Enums.CharacterPreset.size() - 1
		selected_preset = Enums.CharacterPreset.values()[new_preset]
