extends Control

var hippo_player_scene = preload("res://scenes/hippo_player.tscn")

@onready var scroll_container: ScrollContainer = $VBoxContainer/MarginContainer/ScrollContainer
@onready var grid_container: GridContainer = $VBoxContainer/MarginContainer/ScrollContainer/GridContainer
@onready var select_tile: TileMapLayer = $VBoxContainer/MarginContainer/ScrollContainer/GridContainer/SelectTile

const animations = [
	Enums.PlayerAnimation.IDLE,
	Enums.PlayerAnimation.READY,
	Enums.PlayerAnimation.RUN,
]

var selected_preset := Enums.CharacterPreset.ASTRONAUT

func _ready() -> void:
	for preset in Enums.CharacterPreset.values():
		var control = Control.new()
		control.custom_minimum_size = Vector2i(192, 240)
		control.size_flags_horizontal = Control.SIZE_EXPAND
		grid_container.add_child(control)
		
		var character = hippo_player_scene.instantiate()
		character.characterPreset = preset
		character.animation = animations.pick_random()
		character.scale = Vector2i(8, 8)
		character.position = Vector2i(100, 260)
		character.playAnimation()
		control.add_child(character)

func _process(_delta: float) -> void:
	for child in grid_container.get_children():
		if child.get_class() != "Control":
			continue
		var character = child.get_child(0)
		if character.characterPreset == selected_preset:
			select_tile.position = child.position
			scroll_container.ensure_control_visible(child)

enum Direction { LEFT, RIGHT, UP, DOWN }

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_right"):
		selected_preset = move_grid_selection(Direction.RIGHT)
	elif event.is_action_pressed("move_left"):
		selected_preset = move_grid_selection(Direction.LEFT)
	elif event.is_action_pressed("move_up"):
		selected_preset = move_grid_selection(Direction.UP)
	elif event.is_action_pressed("move_down"):
		selected_preset = move_grid_selection(Direction.DOWN)	

func move_grid_selection(direction: Direction) -> int:
	var index := selected_preset
	var total := Enums.CharacterPreset.size()
	var columns := grid_container.columns
	var rows := floori((total + columns - 1) / columns)
	var row := floori(index / columns)
	var col := index % columns
	var row_size := total % columns if row == rows - 1 else columns
	var col_size := rows - 1 if col >= total % columns else rows
	if direction == Direction.LEFT:
		col = (col - 1 + row_size) % row_size
	elif direction == Direction.RIGHT:
		col = (col + 1) % row_size
	elif direction == Direction.UP:
		row = (row - 1 + col_size) % col_size
	elif direction == Direction.DOWN:
		row = (row + 1) % col_size
	return row * columns + col
