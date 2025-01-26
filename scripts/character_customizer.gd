extends Control

var hippo_player_scene = preload("res://scenes/hippo_player.tscn")

@onready var container: HFlowContainer = $VBoxContainer/ScrollContainer/HFlowContainer

const animations = [
	Enums.PlayerAnimation.IDLE,
	Enums.PlayerAnimation.READY,
	Enums.PlayerAnimation.RUN,
]

func _ready() -> void:
	for preset in Enums.CharacterPreset.values():
		var control = Control.new()
		control.name = str(preset)
		control.custom_minimum_size = Vector2i(250, 340)
		container.add_child(control)
		
		var character = hippo_player_scene.instantiate()
		character.characterPreset = preset
		character.animation = animations.pick_random()
		character.scale = Vector2i(8, 8)
		character.position = Vector2i(125, 300)
		character.playAnimation()
		control.add_child(character)
