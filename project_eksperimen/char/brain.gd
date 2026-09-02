extends Node

@export_enum("FSM", "Utility", "MAB") var active_ai: String = "FSM"

const TACTICAL_ACTIONS = ["idle", "light_attack", "heavy_attack", "block", "dodge", "use_skill"]

var target: Node2D
@onready var body = $".."
@onready var fsm_agent = get_node_or_null("FSM")
@onready var utility_agent = get_node_or_null("Utility")
@onready var mab_agent = get_node_or_null("MAB")

func _ready():
	target = get_tree().current_scene.get_node_or_null("npc1")
	if target == null:
		push_error("BRAIN: node 'npc1' tidak ditemukan.")
	body.action_finished.connect(_on_body_action_finished)

func _physics_process(_delta):
	if Mod.status != Mod.Status.RUNNING:
		body.execute_motor("idle", Vector2.ZERO)
		return
		
	if target == null:
		body.execute_motor("idle", Vector2.ZERO)
		return
	var distance = body.global_position.distance_to(target.global_position)
	var dir_to_target = body.global_position.direction_to(target.global_position)
	var agent = _current_agent()
	if agent == null:
		body.execute_motor("idle", Vector2.ZERO)
		return

	var t0 := Time.get_ticks_usec()
	var decision = agent.think(distance, dir_to_target)
	var latency := Time.get_ticks_usec() - t0

	if decision.is_empty():
		return
	# Catat hanya aksi taktis (bukan chase/idle)
	var cmd: String = decision["command"]
	if cmd in ["light_attack", "heavy_attack", "block", "dodge", "use_skill"]:
		LoggerGlobal.log_decision(cmd, latency)
	body.execute_motor(cmd, dir_to_target)

func _on_body_action_finished(action: String):
	var agent = _current_agent()
	if agent != null and agent.has_method("on_action_finished"):
		agent.on_action_finished(action)

func _current_agent() -> Node:
	match active_ai:
		"FSM":     return fsm_agent
		"Utility": return utility_agent
		"MAB":     return mab_agent
	return null
