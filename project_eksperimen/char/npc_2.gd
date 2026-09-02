extends CharacterBody2D
# NPC2 = BOSS BODY (motorik murni). Keputusan dari brain via execute_motor().
# Defensif: Dodge = 0 dmg + slide mundur + cooldown | Block = 75% dmg masuk + cooldown

@export var move_speed: float = 80.0
@export var retreat_speed: float = 100.0
@export var max_hp: int = 200
@export var anim_speed: float = 1.8
@export var block_cd: float = 3.0
@export var dodge_cd: float = 5.0
@export var dodge_distance: float = 120.0
@export var dodge_duration: float = 0.2
@export var block_reduction: float = 0.25
@export var mab_reward_c: float = 40.0

@onready var anim = $AnimationPlayer
@onready var pivot = $Pivot
@onready var sprite = $Sprite2D

signal action_finished(action: String)

var facing: String = "down"
var is_attacking: bool = false
var current_action: String = "idle"
var can_block: bool = true
var can_dodge: bool = true
var damage_dealt_this_action: int = 0
var damage_prevented_this_action: int = 0
var damage_taken_this_action: int = 0
var hp: int = 0

const DAMAGE = {"light_attack": 10, "heavy_attack": 30, "use_skill": 40}

func _ready():
	hp = max_hp
	anim.animation_finished.connect(_on_animation_finished)
	anim.speed_scale = anim_speed

func execute_motor(command: String, target_dir: Vector2):
	if target_dir != Vector2.ZERO and not is_attacking:
		_update_facing(target_dir)

	match command:
		"chase":   velocity = target_dir * move_speed
		"retreat": velocity = -target_dir * retreat_speed
		_:         velocity = Vector2.ZERO

	match command:
		"idle":
			if not is_attacking: anim.play("idle")
		"chase", "retreat":
			if not is_attacking: _play_locomotion()
		"light_attack": _start_action("light_attack", _anim_dir("swipe"))
		"heavy_attack": _start_action("heavy_attack", _anim_dir("stomp"))
		"use_skill":    _start_action("use_skill", _anim_dir("useskill"))
		"block":
			if can_block: _start_action("block", "block")
		"dodge":
			if can_dodge: _start_dodge(target_dir)

	move_and_slide()

func _start_action(action_name: String, anim_name: String):
	if is_attacking: return
	is_attacking = true
	current_action = action_name
	_reset_damage_counters()
	anim.play(anim_name)

func _start_dodge(target_dir: Vector2):
	if is_attacking: return
	is_attacking = true
	current_action = "dodge"
	_reset_damage_counters()
	anim.play("dodge")
	var dir = target_dir if target_dir != Vector2.ZERO else Vector2.DOWN
	var end_pos = global_position - dir * dodge_distance
	var tween = create_tween()
	tween.tween_property(self, "global_position", end_pos, dodge_duration)
	tween.tween_callback(_finish_dodge)

func _reset_damage_counters():
	damage_dealt_this_action = 0
	damage_prevented_this_action = 0
	damage_taken_this_action = 0

func _finish_dodge():
	is_attacking = false
	current_action = "idle"
	can_dodge = false
	get_tree().create_timer(dodge_cd).timeout.connect(func(): can_dodge = true)
	emit_signal("action_finished", "dodge")

func _play_locomotion():
	if facing == "side": anim.play("walk_side")
	elif facing == "up": anim.play("walk_up")
	else: anim.play("walk")

func _anim_dir(base: String) -> String:
	if facing == "side": return base + "_side"
	elif facing == "up": return base + "_up"
	return base

func _update_facing(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		facing = "side"
		if dir.x > 0:
			sprite.flip_h = true;  pivot.rotation_degrees = -90; pivot.position = Vector2(15, 0)
		else:
			sprite.flip_h = false; pivot.rotation_degrees = 90;  pivot.position = Vector2(-15, 0)
	else:
		sprite.flip_h = false
		if dir.y > 0:
			facing = "down"; pivot.rotation_degrees = 0;   pivot.position = Vector2(0, 15)
		else:
			facing = "up";   pivot.rotation_degrees = 180; pivot.position = Vector2(0, -15)

func _on_animation_finished(_anim_name: String):
	if is_attacking and current_action != "dodge":   # dodge ditangani tween
		is_attacking = false
		var finished = current_action
		current_action = "idle"
		if finished == "block":
			can_block = false
			get_tree().create_timer(block_cd).timeout.connect(func(): can_block = true)
		emit_signal("action_finished", finished)

func _on_attack_area_area_entered(area: Area2D):
	if area.name == "hurtbox" and area.get_parent().name == "npc1":
		var dmg = DAMAGE.get(current_action, 0)
		var body = area.get_parent()
		if dmg > 0 and body.has_method("take_damage"):
			body.take_damage(dmg)
			damage_dealt_this_action += dmg

func take_damage(amount: int):
	if current_action == "dodge":
		damage_prevented_this_action += amount     # dihindari penuh
	#	print("Dodge! 0 damage.")
		return
	if current_action == "block":
		var reduced = int(amount * (1.0 - block_reduction))
		var prevented = amount - reduced
		damage_prevented_this_action += prevented
		damage_taken_this_action += reduced
		hp -= reduced
	#	print("Block! Masuk ", reduced, " | HP: ", hp)
		if hp <= 0: _on_death()
		return
	# Normal
	damage_taken_this_action += amount
	hp -= amount
#	print("NPC2 (Boss) HP: ", hp)
	if hp <= 0: _on_death()

func _on_death():
	Mod.on_battle_ended("npc1")
