extends Control

var hippo_player_scene = preload("res://scenes/hippo_player.tscn")

@onready var container: HFlowContainer = $VBoxContainer/ScrollContainer/HFlowContainer

const animations = {
	Enums.CharacterPreset.ASTRONAUT: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.CHEF: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.COWBOY: Enums.PlayerAnimation.IDLE,
	Enums.CharacterPreset.DEER: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.GAS_MASK_1: Enums.PlayerAnimation.IDLE,
	Enums.CharacterPreset.GAS_MASK_2: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.GUARDIAN: Enums.PlayerAnimation.IDLE,
	Enums.CharacterPreset.HUMAN: Enums.PlayerAnimation.READY,
	Enums.CharacterPreset.JEDI: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.JUDGE: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.MASTER_CHIEF: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.MAUL: Enums.PlayerAnimation.IDLE,
	Enums.CharacterPreset.MEDIC: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.NIGHT_VISION: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.NINJA: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.PILOT: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.PLAGUE_DOCTOR: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.PREDATOR: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.PUMPKIN: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.ROBOCOP: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.SANTA_HELPER: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.SANTA: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.SHOCK_TROOPER: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.SIDIOUS: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.SOLDIER: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.STORM_TROOPER: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.VADER: Enums.PlayerAnimation.RUN,
	Enums.CharacterPreset.YODA: Enums.PlayerAnimation.READY,
	Enums.CharacterPreset.ZOMBIE: Enums.PlayerAnimation.READY,
}

func _ready() -> void:
	for preset in Enums.CharacterPreset.values():
		var control = Control.new()
		control.name = str(preset)
		control.custom_minimum_size = Vector2i(250, 340)
		container.add_child(control)
		
		var character = hippo_player_scene.instantiate()
		character.characterPreset = preset
		character.animation = animations[preset]
		character.scale = Vector2i(8, 8)
		character.position = Vector2i(125, 300)
		character.playAnimation()
		control.add_child(character)
