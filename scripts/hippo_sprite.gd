class_name HippoSprite
extends Node2D


@onready var armorSprite: AnimatedSprite2D = $Armor
@onready var armsSprite: AnimatedSprite2D = $Arms
@onready var bodySprite: AnimatedSprite2D = $Body
@onready var earsSprite: AnimatedSprite2D = $Ears
@onready var eyesSprite: AnimatedSprite2D = $Eyes
@onready var headSprite: AnimatedSprite2D = $Head
@onready var helmetSprite: AnimatedSprite2D = $Helmet
@onready var gunSprite: AnimatedSprite2D = $Gun

var sprites = [
	armorSprite,
	armsSprite,
	bodySprite,
	earsSprite,
	eyesSprite,
	headSprite,
	helmetSprite,
]

# When instantiating programmatically, need to manually reconnect
# since @onready only connects once in _ready
func getSprites():
	armorSprite = get_node("Armor")
	armsSprite = get_node("Arms")
	bodySprite = get_node("Body")
	earsSprite = get_node("Ears")
	eyesSprite = get_node("Eyes")
	headSprite = get_node("Head")
	helmetSprite = get_node("Helmet")
	gunSprite = get_node("Gun")

var PlayerAnimation := Enums.PlayerAnimation
@export var animation := PlayerAnimation.IDLE

func getPlayerAnimationString(playerAnimation: Enums.PlayerAnimation):
	const ANIMATION_STRINGS = {
		PlayerAnimation.CLIMB: "climb",
		PlayerAnimation.IDLE: "idle",
		PlayerAnimation.READY: "ready",
		PlayerAnimation.RUN: "run"
	}
	return ANIMATION_STRINGS[playerAnimation]

var CharacterPreset := Enums.CharacterPreset
@export var characterPreset := CharacterPreset.HUMAN

const helmetPresets = [
	CharacterPreset.ASTRONAUT,
	CharacterPreset.CHEF,
	CharacterPreset.COWBOY,
	CharacterPreset.DEER,
	CharacterPreset.GAS_MASK_1,
	CharacterPreset.GAS_MASK_2,
	CharacterPreset.GUARDIAN,
	CharacterPreset.JEDI,
	CharacterPreset.JUDGE,
	CharacterPreset.MASTER_CHIEF,
	CharacterPreset.MEDIC,
	CharacterPreset.NIGHT_VISION,
	CharacterPreset.NINJA,
	CharacterPreset.PILOT,
	CharacterPreset.PLAGUE_DOCTOR,
	CharacterPreset.PREDATOR,
	CharacterPreset.PUMPKIN,
	CharacterPreset.ROBOCOP,
	CharacterPreset.SANTA_HELPER,
	CharacterPreset.SANTA,
	CharacterPreset.SHOCK_TROOPER,
	CharacterPreset.SIDIOUS,
	CharacterPreset.SOLDIER,
	CharacterPreset.STORM_TROOPER,
	CharacterPreset.VADER,
]

const armsPresets = [
	CharacterPreset.ASTRONAUT,
	CharacterPreset.CHEF,
	CharacterPreset.COWBOY,
	CharacterPreset.DEER,
	CharacterPreset.GAS_MASK_1,
	CharacterPreset.GAS_MASK_2,
	CharacterPreset.GUARDIAN,
	CharacterPreset.JEDI,
	CharacterPreset.JUDGE,
	CharacterPreset.MASTER_CHIEF,
	CharacterPreset.MEDIC,
	CharacterPreset.MAUL,
	CharacterPreset.NIGHT_VISION,
	CharacterPreset.NINJA,
	CharacterPreset.PILOT,
	CharacterPreset.PLAGUE_DOCTOR,
	CharacterPreset.PREDATOR,
	CharacterPreset.PUMPKIN,
	CharacterPreset.ROBOCOP,
	CharacterPreset.SANTA_HELPER,
	CharacterPreset.SANTA,
	CharacterPreset.SHOCK_TROOPER,
	CharacterPreset.SIDIOUS,
	CharacterPreset.SOLDIER,
	CharacterPreset.STORM_TROOPER,
	CharacterPreset.VADER,
]

func getCharacterPresetString(preset: Enums.CharacterPreset):
	const PRESET_STRINGS = {
		CharacterPreset.ASTRONAUT: "Astronaut",
		CharacterPreset.CHEF: "Chef",
		CharacterPreset.COWBOY: "Cowboy",
		CharacterPreset.DEER: "Deer",
		CharacterPreset.GAS_MASK_1: "GasMask1",
		CharacterPreset.GAS_MASK_2: "GasMask2",
		CharacterPreset.GUARDIAN: "Guardian",
		CharacterPreset.HUMAN: "Human",
		CharacterPreset.JEDI: "Jedi",
		CharacterPreset.JUDGE: "Judge",
		CharacterPreset.MASTER_CHIEF: "MasterChief",
		CharacterPreset.MEDIC: "Medic",
		CharacterPreset.MAUL: "Maul",
		CharacterPreset.NIGHT_VISION: "NightVision",
		CharacterPreset.NINJA: "Ninja",
		CharacterPreset.PILOT: "Pilot",
		CharacterPreset.PLAGUE_DOCTOR: "PlagueDoctor",
		CharacterPreset.PREDATOR: "Predator",
		CharacterPreset.PUMPKIN: "Pumpkin",
		CharacterPreset.ROBOCOP: "Robocop",
		CharacterPreset.SANTA_HELPER: "SantaHelper",
		CharacterPreset.SANTA: "Santa",
		CharacterPreset.SHOCK_TROOPER: "ShockTrooper",
		CharacterPreset.SIDIOUS: "Sidious",
		CharacterPreset.SOLDIER: "Soldier",
		CharacterPreset.STORM_TROOPER: "StormTrooper",
		CharacterPreset.VADER: "Vader",
		CharacterPreset.YODA: "Yoda",
		CharacterPreset.ZOMBIE: "Zombie",
	}
	return PRESET_STRINGS[preset]

func getSpriteAnimation():
	return getCharacterPresetString(characterPreset) + "_" + getPlayerAnimationString(animation)

func playAnimation():
	if null in sprites: getSprites()
	
	var spriteAnimation = getSpriteAnimation()
	
	if characterPreset not in helmetPresets:
		bodySprite.play(spriteAnimation)
		headSprite.play(spriteAnimation)
		armsSprite.play(spriteAnimation)
		eyesSprite.play(spriteAnimation)
	
	if characterPreset == CharacterPreset.YODA:
		earsSprite.play(spriteAnimation)
	elif characterPreset in helmetPresets:
		var humanAnimation = "Human_" + getPlayerAnimationString(animation)
		if characterPreset in armsPresets:
			armsSprite.play(humanAnimation)
		bodySprite.play(humanAnimation)
		eyesSprite.play(humanAnimation)
		headSprite.play(humanAnimation)
	
		armorSprite.play(spriteAnimation)
		helmetSprite.play(spriteAnimation)
	
	var gunAnimation = "Bolt_" + getPlayerAnimationString(animation)
	gunSprite.play(gunAnimation)

func setCharacterPreset():
	var spriteAnimation = getSpriteAnimation()
	
	if characterPreset not in helmetPresets:
		bodySprite.animation = spriteAnimation
		headSprite.animation = spriteAnimation
		eyesSprite.animation = spriteAnimation
		armsSprite.animation = spriteAnimation
	
	if characterPreset == CharacterPreset.YODA:
		earsSprite.visible = true
		earsSprite.animation = spriteAnimation
	else:
		earsSprite.visible = false
	
	if characterPreset in helmetPresets:
		var humanAnimation = "Human_" + getPlayerAnimationString(animation)
		bodySprite.animation = humanAnimation
		headSprite.animation = humanAnimation
		eyesSprite.animation = humanAnimation
		if characterPreset in armsPresets:
			armsSprite.animation = humanAnimation
	
		armorSprite.animation = spriteAnimation
		helmetSprite.animation = spriteAnimation
		armorSprite.visible = true
		helmetSprite.visible = true
	else:
		armorSprite.visible = false
		helmetSprite.visible = false

func equip_gun() -> void:
	armsSprite.visible = false
	gunSprite.visible = true

func updateCardinal() -> void:
	if cardinal in [Enums.Cardinal.EAST, Enums.Cardinal.WEST]:
		gunSprite.rotation_degrees = 0
		gunSprite.offset = Vector2i(0, 12)
		move_child(gunSprite, -1)
	elif cardinal in [Enums.Cardinal.SOUTH_EAST, Enums.Cardinal.SOUTH_WEST]:
		gunSprite.rotation_degrees = 45
		gunSprite.offset = Vector2i(0, 12)
		move_child(gunSprite, -1)
	elif cardinal == Enums.Cardinal.SOUTH:
		gunSprite.rotation_degrees = 90
		gunSprite.offset = Vector2i(0, 12)
		move_child(gunSprite, -1)
	elif cardinal in [Enums.Cardinal.NORTH_EAST, Enums.Cardinal.NORTH_WEST]:
		gunSprite.rotation_degrees = -45
		gunSprite.offset = Vector2i(0, 12)
		move_child(gunSprite, -1)
	elif cardinal == Enums.Cardinal.NORTH:
		gunSprite.rotation_degrees = -90
		gunSprite.offset = Vector2i(4, 12)
		move_child(gunSprite, 0)

@export var cardinal := Enums.Cardinal.EAST:
	set(new_cardinal):
		if cardinal == new_cardinal: return
		cardinal = new_cardinal
		updateCardinal()

func _ready() -> void:
	setCharacterPreset()
