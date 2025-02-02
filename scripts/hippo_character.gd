class_name HippoCharacter
extends CharacterBody2D

@onready var sprite: HippoSprite = $HippoSprite

var cardinal := Enums.Cardinal.EAST

func _ready() -> void:
	sprite.equip_gun()

func _physics_process(_delta):
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_vector.x > 0:
		sprite.scale = Vector2i(1, 1)
	elif input_vector.x < 0:
		sprite.scale = Vector2i(-1, 1)
	
	
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
	if sprite.animation not in [Enums.PlayerAnimation.CLIMB, Enums.PlayerAnimation.RUN]:
		sprite.stopAnimation()
	#else:
		#sprite.stopAnimation()
