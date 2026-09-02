extends Camera2D
# Kamera mengikuti titik tengah antara npc1 (dummy) dan npc2 (boss).
# Zoom tetap (diatur manual di Inspector).

@export var follow_speed: float = 5.0  # kehalusan gerak kamera

var npc1: Node2D
var npc2: Node2D

func _ready():
	npc1 = get_tree().current_scene.get_node_or_null("npc1")
	npc2 = get_tree().current_scene.get_node_or_null("npc2")

func _physics_process(delta):
	if npc1 == null or npc2 == null:
		return
	var midpoint = (npc1.global_position + npc2.global_position) * 0.5
	global_position = global_position.lerp(midpoint, follow_speed * delta)
