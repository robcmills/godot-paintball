extends Node2D

var paintball_scene = preload("res://scenes/paintball.tscn")

@export var player: HippoCharacter
@export var speed := 100  # speed in pixels/sec


func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	player.velocity = direction * speed
	player.move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		shoot()

func shoot() -> void:
	var paintball := paintball_scene.instantiate()
	paintball.position = player.sprite.muzzle_marker.global_position
	paintball.direction = Enums.cardinalToVector(player.cardinal)
	add_child(paintball)
