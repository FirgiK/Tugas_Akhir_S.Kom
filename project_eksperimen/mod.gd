extends Node
# MOD (Moderator) — pengatur eksperimen. Autoload.

enum Status { IDLE, RUNNING, STOPPED }
const TOTAL_SESSIONS := 30

var selected_agent: String = "FSM"
var current_session: int = 0
var status: int = Status.IDLE
var battle_start_time: int = 0
var _battle_ended: bool = false   # cegah double-lapor dalam satu sesi

signal state_changed

func start(agent: String):
	if status == Status.RUNNING:
		return
	selected_agent = agent
	current_session = 0
	status = Status.RUNNING
	emit_signal("state_changed")
	_load_next_session()

func stop():
	status = Status.STOPPED
	emit_signal("state_changed")

func reset():
	status = Status.IDLE
	current_session = 0
	emit_signal("state_changed")
	get_tree().call_deferred("reload_current_scene")

func _load_next_session():
	current_session += 1
	if current_session > TOTAL_SESSIONS:
		_finish_experiment()
		return
	_battle_ended = false
	get_tree().call_deferred("reload_current_scene")

func _finish_experiment():
	status = Status.IDLE
	emit_signal("state_changed")
	LoggerGlobal.close_agent(selected_agent)
	print("=== SELESAI: ", TOTAL_SESSIONS, " sesi ", selected_agent, " ===")

# Dipanggil stage._ready tiap scene selesai dimuat
func on_scene_ready(brain: Node):
	if status != Status.RUNNING:
		return
	brain.active_ai = selected_agent
	seed(current_session)
	battle_start_time = Time.get_ticks_msec()
	# Ukur memori statis (byte) saat sesi mulai
	var mem_bytes := Performance.get_monitor(Performance.MEMORY_STATIC)
	LoggerGlobal.begin_session(selected_agent, current_session, current_session, mem_bytes)
	emit_signal("state_changed")

# Dipanggil npc saat pertarungan selesai
func on_battle_ended(winner: String):
	if status != Status.RUNNING or _battle_ended:
		return
	_battle_ended = true
	var survival_sec := (Time.get_ticks_msec() - battle_start_time) / 1000.0
	LoggerGlobal.end_session(survival_sec, winner)
	print("Sesi ", current_session, "/", TOTAL_SESSIONS,
		" | ", selected_agent, " | survival: ", snapped(survival_sec, 0.01), "s | winner: ", winner)
	_load_next_session()

func get_elapsed_sec() -> float:
	if status != Status.RUNNING:
		return 0.0
	return (Time.get_ticks_msec() - battle_start_time) / 1000.0
