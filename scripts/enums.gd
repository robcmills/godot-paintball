extends Node

enum Cardinal {
	EAST,
	SOUTH_EAST,
	SOUTH,
	SOUTH_WEST,
	WEST,
	NORTH_WEST,
	NORTH,
	NORTH_EAST,
}

func cardinalToVector(cardinal: int) -> Vector2:
	match cardinal:
		Cardinal.EAST:
			return Vector2(1, 0)
		Cardinal.SOUTH_EAST:
			return Vector2(1, 1).normalized()
		Cardinal.SOUTH:
			return Vector2(0, 1)
		Cardinal.SOUTH_WEST:
			return Vector2(-1, 1).normalized()
		Cardinal.WEST:
			return Vector2(-1, 0)
		Cardinal.NORTH_WEST:
			return Vector2(-1, -1).normalized()
		Cardinal.NORTH:
			return Vector2(0, -1)
		Cardinal.NORTH_EAST:
			return Vector2(1, -1).normalized()
		_:
			return Vector2.ZERO  # Fallback in case of an invalid input

enum CharacterPreset {
	ASTRONAUT,
	CHEF,
	COWBOY,
	DEER,
	GAS_MASK_1,
	GAS_MASK_2,
	GUARDIAN,
	HUMAN,
	JEDI,
	JUDGE,
	MASTER_CHIEF,
	MEDIC,
	MAUL,
	NIGHT_VISION,
	NINJA,
	PILOT,
	PLAGUE_DOCTOR,
	PREDATOR,
	PUMPKIN,
	ROBOCOP,
	SANTA_HELPER,
	SANTA,
	SHOCK_TROOPER,
	SIDIOUS,
	SOLDIER,
	STORM_TROOPER,
	VADER,
	YODA,
	ZOMBIE,
}

enum PlayerAnimation {
	CLIMB,
	CLIMB_IDLE,
	IDLE,
	READY,
	RUN,
}

enum Weapon {
	BOLT,
	NONE,
}
