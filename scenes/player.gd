class_name HippoCharacter
extends CharacterBody2D

@onready var armorSprite: AnimatedSprite2D = $CompositeSprite/Armor
@onready var armsSprite: AnimatedSprite2D = $CompositeSprite/Arms
@onready var bodySprite: AnimatedSprite2D = $CompositeSprite/Body
@onready var earsSprite: AnimatedSprite2D = $CompositeSprite/Ears
@onready var eyesSprite: AnimatedSprite2D = $CompositeSprite/Eyes
@onready var headSprite: AnimatedSprite2D = $CompositeSprite/Head
@onready var helmetSprite: AnimatedSprite2D = $CompositeSprite/Helmet

var sprites = [
	armorSprite,
	armsSprite,
	bodySprite,
	earsSprite,
	eyesSprite,
	headSprite,
	helmetSprite,
]

# When duplicating player instances, need to manually reconnect
# since @onready only connects once in _ready
func getSprites():
	armorSprite = get_node("CompositeSprite/Armor")
	armsSprite = get_node("CompositeSprite/Arms")
	bodySprite = get_node("CompositeSprite/Body")
	earsSprite = get_node("CompositeSprite/Ears")
	eyesSprite = get_node("CompositeSprite/Eyes")
	headSprite = get_node("CompositeSprite/Head")
	helmetSprite = get_node("CompositeSprite/Helmet")

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
]
const armsPresets = [
	CharacterPreset.CHEF,
	CharacterPreset.COWBOY,
	CharacterPreset.DEER,
]

func getCharacterPresetString(preset: Enums.CharacterPreset):
	const PRESET_STRINGS = {
		CharacterPreset.ASTRONAUT: "Astronaut",
		CharacterPreset.CHEF: "Chef",
		CharacterPreset.COWBOY: "Cowboy",
		CharacterPreset.DEER: "Deer",
		CharacterPreset.HUMAN: "Human",
		CharacterPreset.MAUL: "Maul",
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
		

func _ready() -> void:
	setCharacterPreset()
