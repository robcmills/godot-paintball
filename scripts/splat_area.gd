class_name SplatArea
extends Node2D

var splats := []

func _ready() -> void:
	for area in get_children():
		if area.get_class() == "Area2D":
			area.collision_layer = 2
			area.collision_mask = 2
			area.connect("area_entered", _on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area.owner is Paintball:
		splats.push_back([area.global_position - global_position, area.owner.direction])
		area.owner.queue_free()
		queue_redraw()

func _draw() -> void:
	for i in range(0, splats.size()):
		var splat = splats[i]
		draw_splat(i, splat[0], splat[1])

# The angle in euler degrees in which to draw splat
const SPLAT_SPREAD := 90
# The distance from center splat to furthest
const SPLAT_LENGTH := 8
# The total number of splats to draw
const SPLAT_DENSITY := 8
# The radius of the largest center splat
const SPLAT_MAX_SIZE := 4.0
# The radius of the smallest furthest splat
const SPLAT_MIN_SIZE := 1.0
# The color of the splat
const SPLAT_COLOR := Color("green")
# The amount of randomness to use (higher is more chaotic)
const SPLAT_RANDOMNESS := 4
# The amount of color variation to use
const SPLAT_COLOR_RANDOMNESS := 0.5

var rand = RandomNumberGenerator.new()

func draw_splat(splat_id: int, collision_position: Vector2, splat_direction: Vector2) -> void:
	rand.seed = splat_id
	
	var splat_position = collision_position + splat_direction.normalized() * SPLAT_MAX_SIZE

	# Generate a slightly different color for each splat
	var splat_color = SPLAT_COLOR
	splat_color.r = clamp(
		splat_color.r + (rand.randf() * 2.0 - 1.0) * SPLAT_COLOR_RANDOMNESS, 0.0, 1.0
	)
	splat_color.g = clamp(
		splat_color.g + (rand.randf() * 2.0 - 1.0) * SPLAT_COLOR_RANDOMNESS, 0.0, 1.0
	)
	splat_color.b = clamp(
		splat_color.b + (rand.randf() * 2.0 - 1.0) * SPLAT_COLOR_RANDOMNESS, 0.0, 1.0
	)
	
	draw_rect(
		Rect2(splat_position, Vector2(SPLAT_MAX_SIZE, SPLAT_MAX_SIZE)),
		splat_color
	)
	
	for i in range(1, SPLAT_DENSITY):
		var t = float(i) / float(SPLAT_DENSITY)
		var size = lerp(SPLAT_MAX_SIZE, SPLAT_MIN_SIZE, t)
		var distance = t * SPLAT_LENGTH
		var random_offset = (rand.randf() * 2.0 - 1.0) * SPLAT_SPREAD / 2.0 * SPLAT_RANDOMNESS
		var angle = splat_direction.angle() + deg_to_rad(random_offset)
		var offset = Vector2(cos(angle), sin(angle)) * distance
		var circle_position = splat_position + offset
		draw_rect(
			Rect2(circle_position, Vector2(size, size)),
			splat_color
		)
