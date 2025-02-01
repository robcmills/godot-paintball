extends Node2D

@export var player: HippoCharacter
@export var speed := 100  # speed in pixels/sec

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player.velocity = direction * speed
	player.move_and_slide()
