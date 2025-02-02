class_name HippoCharacter
extends CharacterBody2D

@onready var sprite: HippoSprite = $HippoSprite

var cardinal := Enums.Cardinal.EAST

func _ready() -> void:
	sprite.weapon = Enums.Weapon.BOLT

func _physics_process(_delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	# Flip sprite horizontally.
	if input_vector.x > 0:
		sprite.scale = Vector2i(1, 1)
	elif input_vector.x < 0:
		sprite.scale = Vector2i(-1, 1)
	
	# Determine which sprite animation to play based on cardinal direction player is facing.
	sprite.animation = (
		Enums.PlayerAnimation.CLIMB_IDLE if cardinal == Enums.Cardinal.NORTH
		else Enums.PlayerAnimation.READY
	)
	if input_vector.length() != 0:
		var angle = input_vector.angle() / (PI / 4)
		cardinal = wrapi(roundi(angle), 0, 8) as Enums.Cardinal
		sprite.cardinal = cardinal	
		sprite.animation = (
			Enums.PlayerAnimation.CLIMB if cardinal == Enums.Cardinal.NORTH
			else Enums.PlayerAnimation.RUN
		)
	
	sprite.playAnimation()
	if (
		Globals.animateIdlePlayer == false
		and sprite.animation in [
			Enums.PlayerAnimation.IDLE,
			Enums.PlayerAnimation.CLIMB_IDLE,
			Enums.PlayerAnimation.READY,
		]
	):
		sprite.stopAnimation()
