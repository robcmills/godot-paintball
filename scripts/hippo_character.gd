class_name HippoCharacter
extends CharacterBody2D

@onready var sprite: HippoSprite = $HippoSprite

var cardinal := Enums.Cardinal.EAST

func _ready() -> void:
	sprite.equip_gun()

func _physics_process(delta):
	if velocity.x > 0:
		sprite.scale = Vector2i(1, 1)
	elif velocity.x < 0:
		sprite.scale = Vector2i(-1, 1)
	
	sprite.animation = Enums.PlayerAnimation.READY
	if velocity.length() != 0:
		sprite.animation = Enums.PlayerAnimation.RUN
		var angle = velocity.angle() / (PI / 4)
		cardinal = wrapi(roundi(angle), 0, 8)
	
	sprite.playAnimation()
