extends CanvasLayer
# UI eksperimen. Menampilkan status Mod & mengirim perintah start/stop/reset.

@onready var dropdown: OptionButton = $Panel/Agent
@onready var start_btn: Button = $Panel/StartButton
@onready var stop_btn: Button = $Panel/StopButton
@onready var reset_btn: Button = $Panel/ResetButton
@onready var session_label: Label = $Panel/SessionLabel
@onready var timer_label: Label = $Panel/TimerLabel
@onready var status_label: Label = $Panel/StatusLabel

func _ready():
	dropdown.clear()
	dropdown.add_item("FSM")
	dropdown.add_item("Utility")
	dropdown.add_item("MAB")
	start_btn.pressed.connect(_on_start)
	stop_btn.pressed.connect(_on_stop)
	reset_btn.pressed.connect(_on_reset)
	Mod.state_changed.connect(_refresh)
	_refresh()

func _process(_delta):
	if Mod.status == Mod.Status.RUNNING:
		timer_label.text = "Waktu: %.1f s" % Mod.get_elapsed_sec()

func _on_start():
	Mod.start(dropdown.get_item_text(dropdown.selected))

func _on_stop():
	Mod.stop()

func _on_reset():
	Mod.reset()

func _refresh():
	var running := Mod.status == Mod.Status.RUNNING
	dropdown.disabled = running        # kunci agen saat berjalan
	start_btn.disabled = running
	session_label.text = "Sesi: %d / %d" % [Mod.current_session, Mod.TOTAL_SESSIONS]
	match Mod.status:
		Mod.Status.IDLE:    status_label.text = "Status: Idle"
		Mod.Status.RUNNING: status_label.text = "Status: Recording..."
		Mod.Status.STOPPED: status_label.text = "Status: Stopped"
