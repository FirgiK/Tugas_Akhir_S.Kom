extends Node
# MAB epsilon-greedy (context-free, constant step-size).
# Reward dihitung langsung saat aksi selesai (damage sudah matang karena
# hitbox nyala di frame tengah, action_finished dipancarkan setelah animasi kelar).

@export var attack_range: float = 110.0
@export var epsilon: float = 0.1
@export var alpha: float = 0.15

@onready var boss = $"../.."

const ACTIONS = ["light_attack", "heavy_attack", "block", "dodge", "use_skill"]

var q_values: Dictionary = {}
var action_count: Dictionary = {}
var pending_action: String = ""

func _ready():
	for a in ACTIONS:
		q_values[a] = 0.0
		action_count[a] = 0

func think(distance: float, dir_to_target: Vector2) -> Dictionary:
	if boss.is_attacking:
		return {}
	if distance > attack_range:
		return {"command": "chase", "dir": dir_to_target}

	var action: String = _select_action()
	pending_action = action
	#print("[MAB] pilih ", action, " | Q=", _q_snapshot())
	return {"command": action, "dir": dir_to_target}

func _select_action() -> String:
	var available: Array = []
	for a in ACTIONS:
		if a == "block" and not boss.can_block: continue
		if a == "dodge" and not boss.can_dodge: continue
		available.append(a)
	if available.is_empty():
		available = ["light_attack"]

	if randf() < epsilon:
		return available[randi() % available.size()]

	var best: String = available[0]
	var best_q: float = q_values[best]
	for a in available:
		if q_values[a] > best_q:
			best_q = q_values[a]
			best = a
	return best

# Reward dihitung LANGSUNG saat aksi selesai (tanpa tunda frame).
func on_action_finished(action: String):
	if action != pending_action:
		return
	var reward: float = _compute_reward(action)
	q_values[action] += alpha * (reward - q_values[action])
	action_count[action] += 1
	#print("[MAB] ", action, " reward=", snapped(reward, 0.01),
	#	" -> Q=", snapped(q_values[action], 0.01))
	pending_action = ""

func _compute_reward(action: String) -> float:
	var dealt: int = boss.damage_dealt_this_action
	var prevented: int = boss.damage_prevented_this_action
	var taken: int = boss.damage_taken_this_action
	var c: float = boss.mab_reward_c
	#print("   [debug] dealt=", dealt, " prevented=", prevented, " taken=", taken)
	if action in ["block", "dodge"]:
		return (prevented - taken) / c
	return (dealt - taken) / c

func _q_snapshot() -> String:
	var s: String = ""
	for a in ACTIONS:
		s += a.substr(0, 2) + ":" + str(snapped(q_values[a], 0.01)) + " "
	return s
