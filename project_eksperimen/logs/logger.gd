extends Node
# LOGGER — tulis data mentah (per-keputusan) & ringkasan (per-sesi) ke CSV.

const DIR := "user://logs/"

var _agent: String = ""
var _session: int = 0
var _seed: int = 0
var _decisions: Array = [] # baris mentah sesi ini: [action, timestamp_ms, latency_us]
var _mem_bytes: float = 0.0


func _ready():
	DirAccess.make_dir_recursive_absolute(DIR)

# Dipanggil Mod saat sesi mulai
func begin_session(agent: String, session: int, seed_val: int, mem_bytes: float):
	_agent = agent
	_session = session
	_seed = seed_val
	_mem_bytes = mem_bytes
	_decisions.clear()
	_ensure_header("raw_" + agent + ".csv",
		"session,seed,agent,action,timestamp_ms,latency_us")
	_ensure_header("summary_" + agent + ".csv",
		"session,seed,agent,survival_sec,total_decisions,winner,mem_mb")

# Dipanggil agen/brain tiap keputusan aksi taktis dibuat
func log_decision(action: String, latency_us: int):
	if _agent == "":
		return
	var ts := Time.get_ticks_msec()
	_decisions.append([action, ts, latency_us])

# Dipanggil Mod saat sesi selesai
func end_session(survival_sec: float, winner: String):
	if _agent == "":
		return
	var raw := FileAccess.open(DIR + "raw_" + _agent + ".csv", FileAccess.READ_WRITE)
	raw.seek_end()
	for d in _decisions:
		raw.store_line("%d,%d,%s,%s,%d,%d" % [_session, _seed, _agent, d[0], d[1], d[2]])
	raw.close()
	var mem_mb := _mem_bytes / (1024.0 * 1024.0)   # byte -> MB
	var sum := FileAccess.open(DIR + "summary_" + _agent + ".csv", FileAccess.READ_WRITE)
	sum.seek_end()
	sum.store_line("%d,%d,%s,%.3f,%d,%s,%.3f" % [_session, _seed, _agent, survival_sec, _decisions.size(), winner, mem_mb])
	sum.close()
	_agent = ""

func close_agent(_agent_name: String):
	pass # placeholder, file sudah ditutup tiap sesi

func _ensure_header(filename: String, header: String):
	if not FileAccess.file_exists(DIR + filename):
		var f := FileAccess.open(DIR + filename, FileAccess.WRITE)
		f.store_line(header)
		f.close()
