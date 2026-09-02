extends Node2D
func _ready():
	var brain = $npc2/Brain
	if brain != null:
		Mod.on_scene_ready(brain)
