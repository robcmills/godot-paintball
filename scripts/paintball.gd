class_name Paintball extends Node2D

@export var speed := 500.0 # 750.0
@export var lifetime := 5.0

var direction := Vector2.ZERO

@onready var timer := $Timer
@onready var hitbox := $Hitbox
#@onready var sprite := $Sprite


func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	timer.start(lifetime)


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


func _on_timer_timeout() -> void:
	queue_free()
