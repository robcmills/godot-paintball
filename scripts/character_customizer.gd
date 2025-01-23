extends Control

@onready var astronaut: CharacterBody2D = $Astronaut
@onready var chef: CharacterBody2D = $Chef
@onready var cowboy: CharacterBody2D = $Cowboy
@onready var human: CharacterBody2D = $Human
@onready var maul: CharacterBody2D = $Maul
@onready var yoda: CharacterBody2D = $Yoda
@onready var zombie: CharacterBody2D = $Zombie

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	astronaut.playAnimation()
	chef.playAnimation()
	cowboy.playAnimation()
	human.playAnimation()
	maul.playAnimation()
	yoda.playAnimation()
	zombie.playAnimation()
