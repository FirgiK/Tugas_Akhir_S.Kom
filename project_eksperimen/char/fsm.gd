extends Node
# FSM MURNI: M = (S, Σ, δ, s0, F). Transisi deterministik (tanpa RNG/memori luar).
# Skill via rentang HP. Kritis: coba defensif; jika cooldown habis -> SERANG.

enum State { IDLE, CHASE, LIGHT_ATTACK, HEAVY_ATTACK, BLOCK, DODGE, USE_SKILL }

@export var attack_range: float = 110.0
@export var close_range: float = 85.0
@export var flee_hp_ratio: float = 0.25
@export var skill_hp_ratio: float = 0.5

var current_state: State = State.IDLE
var previous_state: State = State.IDLE
@onready var boss = $"../.."
var max_hp: float = 1.0

const STATE_COMMAND = {
	State.IDLE: "idle", State.CHASE: "chase",
	State.LIGHT_ATTACK: "light_attack", State.HEAVY_ATTACK: "heavy_attack",
	State.BLOCK: "block", State.DODGE: "dodge", State.USE_SKILL: "use_skill",
}

func _ready():
	max_hp = float(boss.max_hp)
	if max_hp <= 0: max_hp = 1.0

func think(distance: float, dir_to_target: Vector2) -> Dictionary:
	if boss.is_attacking: return {}
	current_state = _transition(distance, float(boss.hp) / max_hp)
	if current_state != previous_state:
	#	print("FSM -> ", State.keys()[current_state],
	#		" | jarak: ", snapped(distance, 0.1), " | hp: ", boss.hp)
		previous_state = current_state
	return {"command": STATE_COMMAND[current_state], "dir": dir_to_target}

# δ: S × Σ → S
func _transition(distance: float, hp_ratio: float) -> State:
	# 1. Luar jangkauan -> kejar
	if distance > attack_range:
		return State.CHASE

	# 2. HP kritis -> defensif; jika defensif habis (cooldown) -> serang
	if hp_ratio <= flee_hp_ratio:
		if distance <= close_range:
			if boss.can_dodge: return State.DODGE
			if boss.can_block: return State.BLOCK
			return State.HEAVY_ATTACK
		else:
			if boss.can_block: return State.BLOCK
			return State.LIGHT_ATTACK

	# 3. HP menengah -> skill saat dekat, else light
	if hp_ratio <= skill_hp_ratio:
		return State.USE_SKILL if distance <= close_range else State.LIGHT_ATTACK

	# 4. HP sehat -> heavy saat dekat, else light
	return State.HEAVY_ATTACK if distance <= close_range else State.LIGHT_ATTACK

func on_action_finished(_action: String):
	pass
