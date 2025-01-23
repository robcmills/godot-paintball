extends Control

@onready var human: CharacterBody2D = $Human
@onready var maul: CharacterBody2D = $Maul
@onready var yoda: CharacterBody2D = $Yoda
@onready var zombie: CharacterBody2D = $Zombie

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	human.playAnimation()
	maul.playAnimation()
	yoda.playAnimation()
	zombie.playAnimation()
