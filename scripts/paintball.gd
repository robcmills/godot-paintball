class_name Paintball extends Node2D

@export var speed := 750.0
@export var lifetime := 3.0

var direction := Vector2.ZERO

@onready var timer := $Timer
#@onready var hitbox := $HitBox
@onready var sprite := $Sprite
#@onready var impact_detector := $ImpactDetector


func _ready():
	set_as_top_level(true)
	look_at(position + direction)
	timer.start(lifetime)
	#impact_detector.connect("body_entered", self, "_on_impact")


func _physics_process(delta: float) -> void:
	position += direction * speed * delta


#func _on_impact(_body: Node) -> void:
	#queue_free()


func _on_timer_timeout() -> void:
	queue_free()
