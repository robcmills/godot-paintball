extends CharacterBody2D

@onready var armsSprite: AnimatedSprite2D = $CompositeSprite/Arms
@onready var bodySprite: AnimatedSprite2D = $CompositeSprite/Body
@onready var earsSprite: AnimatedSprite2D = $CompositeSprite/Ears
@onready var eyesSprite: AnimatedSprite2D = $CompositeSprite/Eyes
@onready var headSprite: AnimatedSprite2D = $CompositeSprite/Head

enum PlayerAnimation { CLIMB, IDLE, READY, RUN }
@export var animation := PlayerAnimation.IDLE

func getPlayerAnimationString(playerAnimation: PlayerAnimation):
	const ANIMATION_STRINGS = {
		PlayerAnimation.CLIMB: "climb",
		PlayerAnimation.IDLE: "idle",
		PlayerAnimation.READY: "ready",
		PlayerAnimation.RUN: "run"
	}
	return ANIMATION_STRINGS[playerAnimation]

enum CharacterPreset { HUMAN, MAUL, YODA, ZOMBIE }
@export var characterPreset := CharacterPreset.HUMAN

func getCharacterPresetString(preset: CharacterPreset):
	const PRESET_STRINGS = {
		CharacterPreset.HUMAN: "Human",
		CharacterPreset.MAUL: "Maul",
		CharacterPreset.YODA: "Yoda",
		CharacterPreset.ZOMBIE: "Zombie",
	}
	return PRESET_STRINGS[preset]

enum BodyType { HUMAN, MAUL, YODA, ZOMBIE }
var body := BodyType.HUMAN

enum HeadType { HUMAN, MAUL, YODA, ZOMBIE }
var head := HeadType.HUMAN

func getSpriteAnimation():
	return getCharacterPresetString(characterPreset) + "_" + getPlayerAnimationString(animation)

func playAnimation():
	var spriteAnimation = getSpriteAnimation()
	bodySprite.play(spriteAnimation)
	headSprite.play(spriteAnimation)
	armsSprite.play(spriteAnimation)
	eyesSprite.play(spriteAnimation)
	
	if characterPreset == CharacterPreset.YODA:
		earsSprite.play(spriteAnimation)

func setCharacterPreset():
	var spriteAnimation = getSpriteAnimation()
	bodySprite.animation = spriteAnimation
	headSprite.animation = spriteAnimation
	eyesSprite.animation = spriteAnimation
	armsSprite.animation = spriteAnimation
	
	if characterPreset == CharacterPreset.YODA:
		earsSprite.visible = true
		earsSprite.animation = spriteAnimation
	else:
		earsSprite.visible = false

func _ready() -> void:
	setCharacterPreset()
