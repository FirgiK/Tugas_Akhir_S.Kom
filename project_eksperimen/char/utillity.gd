extends Node
# UTILITY-BASED AI: U(aᵢ) = Σ wⱼ·fⱼ(aᵢ,s), aksi = argmax U (deterministik).
# Ambang identik FSM. Dodge=sangat dekat, Block=ada jarak. Defensif cooldown
# dilewati -> serangan menang otomatis (padanan "defensif habis -> serang").

@export var attack_range: float = 110.0
@export var close_range: float = 85.0
@export var w_distance: float = 1.0
@export var w_hp: float = 1.0
@export var hysteresis_bonus: float = 0.15

var last_command: String = "idle"
@onready var boss = $"../.."
var max_hp: float = 1.0

const ACTIONS = ["light_attack", "heavy_attack", "block", "dodge", "use_skill"]

func _ready():
	max_hp = float(boss.max_hp)
	if max_hp <= 0: max_hp = 1.0

func think(distance: float, dir_to_target: Vector2) -> Dictionary:
	if boss.is_attacking: return {}

	var hp_ratio: float = float(boss.hp) / max_hp
	if distance > attack_range:
		last_command = "chase"
		return {"command": "chase", "dir": dir_to_target}

	var best_action := "light_attack"
	var best_score := -INF
	for action in ACTIONS:
		if action == "block" and not boss.can_block: continue
		if action == "dodge" and not boss.can_dodge: continue
		var score := _utility(action, distance, hp_ratio)
		if action == last_command: score += hysteresis_bonus
		if score > best_score:
			best_score = score
			best_action = action

#	if best_action != last_command:
#		print("[UTILITY] -> ", best_action,
#			" | jarak: ", snapped(distance, 0.1), " | hp: ", snapped(hp_ratio, 0.01))
	last_command = best_action
	return {"command": best_action, "dir": dir_to_target}

@export var min_distance: float = 84.0   # jarak terdekat yg mungkin (batas collision)

func _utility(action: String, distance: float, hp_ratio: float) -> float:
	# Normalisasi jarak ke rentang EFEKTIF [min_distance, attack_range] -> [1, 0]
	# closeness=1 saat menempel (84px), closeness=0 saat di tepi jangkauan (110px)
	var span := attack_range - min_distance
	var closeness := clampf((attack_range - distance) / span, 0.0, 1.0)

	match action:
		"light_attack":
			return w_distance * (0.5 + 0.3 * (1.0 - closeness)) + w_hp * _rising(hp_ratio)

		"heavy_attack":
			return w_distance * closeness + w_hp * _rising(hp_ratio)

		"use_skill":
			return w_distance * closeness + w_hp * _mid(hp_ratio)

		"block":
			return w_distance * (0.3 + 0.5 * (1.0 - closeness)) + w_hp * _falling(hp_ratio)

		"dodge":
			return w_distance * closeness + w_hp * _falling(hp_ratio)

	return 0.0

func _rising(v: float) -> float:  return clampf(v, 0.0, 1.0)
func _falling(v: float) -> float: return clampf(1.0 - v, 0.0, 1.0)
func _mid(v: float) -> float:
	var x := (v - 0.5) / 0.25
	return clampf(exp(-x * x), 0.0, 1.0)

func on_action_finished(_action: String):
	pass
