extends CharacterBody2D
# ============================================================
# NPC1 = PLAYER DUMMY (Variabel Kontrol)
# Fixed behavior deterministik: Approach -> Attack 2x -> Retreat -> Repeat
# TIDAK ada RNG, dash acak, atau ghosting. Perilaku wajib reproducible.
# ============================================================

@export var move_speed: float = 100.0
@export var retreat_speed: float = 100.0
@export var hp: int = 400
@export var attack_damage: int = 15
@export var retreat_distance: float = 250.0   # jarak retreat tetap
@export var attack_range: float = 85.0
@export var target: Node2D
@export var anim_speed: float = 1.8

@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var attack_area = $Area2D

# State fixed behavior (bukan FSM AI, hanya urutan skrip pemain)
enum PlayerState { APPROACH, ATTACK, RETREAT }
var current_state: PlayerState = PlayerState.APPROACH

var facing: String = "up"
var is_attacking: bool = false
var attack_count: int = 0
var retreat_anchor: Vector2 = Vector2.ZERO   # titik asal saat mulai retreat

func _ready():
	anim.animation_finished.connect(_on_animation_finished)
	anim.speed_scale = anim_speed

func _physics_process(_delta):
	if Mod.status != Mod.Status.RUNNING:
		_drive_motor("idle", Vector2.ZERO)
		return
		
	var to_target = global_position.direction_to(target.global_position)
	var distance = global_position.distance_to(target.global_position)
	var command = "idle"
	var move_dir = Vector2.ZERO

	# Kunci arah hanya saat tidak menyerang
	if not is_attacking:
		_update_facing(to_target)

	match current_state:
		PlayerState.APPROACH:
			if distance <= attack_range:
				current_state = PlayerState.ATTACK
			else:
				command = "walk"
				move_dir = to_target

		PlayerState.ATTACK:
			command = "attack"          # gerak berhenti saat memukul

		PlayerState.RETREAT:
			# Retreat menjauh dari boss dengan jarak TETAP (deterministik)
			var traveled = global_position.distance_to(retreat_anchor)
			if traveled >= retreat_distance:
				current_state = PlayerState.APPROACH
			else:
				command = "walk"
				move_dir = -to_target    # arah berlawanan dari boss

	_drive_motor(command, move_dir)
	move_and_slide()

func _drive_motor(command: String, dir: Vector2):
	match current_state:
		PlayerState.RETREAT:
			velocity = dir * retreat_speed
		_:
			velocity = dir * move_speed

	if current_state == PlayerState.ATTACK:
		velocity = Vector2.ZERO

	match command:
		"idle":
			if not is_attacking: anim.play("idle")
		"walk":
			if not is_attacking:
				if facing == "side": anim.play("walk_side")
				elif facing == "down": anim.play("walk_down")
				else: anim.play("walk")
		"attack":
			if not is_attacking:
				is_attacking = true
				if facing == "side": anim.play("attack_side")
				elif facing == "down": anim.play("attack_down")
				else: anim.play("attack")

func _update_facing(dir: Vector2):
	if abs(dir.x) > abs(dir.y):
		facing = "side"
		if dir.x > 0:
			sprite.flip_h = true
			attack_area.rotation_degrees = 90
			attack_area.position = Vector2(-25, 0)
		else:
			sprite.flip_h = false
			attack_area.rotation_degrees = -90
			attack_area.position = Vector2(25, 0)
	else:
		sprite.flip_h = false
		if dir.y > 0:
			facing = "down"
			attack_area.rotation_degrees = 180
			attack_area.position = Vector2(0, -50)
		else:
			facing = "up"
			attack_area.rotation_degrees = 0
			attack_area.position = Vector2(0, 0)

func _on_animation_finished(anim_name: String):
	if anim_name in ["attack", "attack_side", "attack_down"]:
		is_attacking = false
		attack_count += 1
		if attack_count >= 2:          # setelah 2x pukul -> retreat
			attack_count = 0
			retreat_anchor = global_position
			current_state = PlayerState.RETREAT

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "hurtbox" and area.get_parent().name == "npc2":
		if "attack" in anim.current_animation:
			var body = area.get_parent()
			if body.has_method("take_damage"):
				body.take_damage(attack_damage)

func take_damage(amount: int):
	hp -= amount
	#print("NPC1 (Dummy) HP: ", hp)
	if hp <= 0:
		_on_death()

func _on_death():
	Mod.on_battle_ended("npc2")
