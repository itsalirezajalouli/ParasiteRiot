extends CharacterBody2D
class_name Player

const ACCELERATION = 500
var MAX_SPEED = global.playerSpeed
const FRICTION = 700

@onready var sprite_2d = $Sprite2D
@export var currentLevel:Node2D
@onready var sprite_2d_2 = $Sprite2D2
@onready var sprite_2d_3 = $Sprite2D3
@export var camera_shake = false
@export var inventory: Inventory
@onready var label = $Label
@onready var collision_shape_2d_2 = $CollisionShape2D2
@onready var collision_shape_2d = $CollisionShape2D
@onready var hurtb_collision_shape_2d_2 = $HurtBox/CollisionShape2D2

enum {
  MOVE,
  ROLL,
  ATTACK
}

var state = MOVE

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree : AnimationTree = $AnimationTree
@onready var animationState = animationTree.get('parameters/playback')
@onready var hitflashanimation = $HitfashAnimationPlayer
@onready var hurtBox = $HurtBox
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2 = $AudioStreamPlayer2D2


const yaroo_instant = preload("res://Enemies/slime.tscn")  

func _ready():
	sprite_2d_2.hide()
	sprite_2d_3.hide()
	label.hide()
	animationTree.active = true
	hitflashanimation.play("RESET")


func _process(delta):
	MAX_SPEED = global.playerSpeed
	print(MAX_SPEED)
	if global.invisible:
		modulate.a = 0.4
	else:
		modulate.a = 1
	if global.type !="none" and Input.is_action_just_pressed("gate") and animationPlayer==$AnimationPlayer_yaroo :
		var yaroo = yaroo_instant.instantiate()  
		get_parent().add_child(yaroo)
		yaroo.position = position
		yaroo.id = global.type
		sprite_2d.show()
		sprite_2d_3.hide()
		sprite_2d_2.hide()
		global.type="none"
		hurtb_collision_shape_2d_2.disabled = false
		collision_shape_2d.disabled = true
		collision_shape_2d_2.disabled = false
		$AnimationPlayer_yaroo.active = false
		$AnimationTree_yaroo.active = false
		animationPlayer = $AnimationPlayer
		animationTree  = $AnimationTree
		animationState = animationTree.get('parameters/playback')
		label.hide()
	if global.type != "none" and animationPlayer!=$AnimationPlayer_yaroo:
		hurtb_collision_shape_2d_2.disabled = false
		collision_shape_2d.disabled = true
		collision_shape_2d_2.disabled = false
		sprite_2d.hide()
		sprite_2d_2.hide()
		sprite_2d_3.show()
		animationTree.active = false
		animationPlayer = $AnimationPlayer_yaroo
		animationTree  = $AnimationTree_yaroo
		animationState = animationTree.get('parameters/playback')
		label.show()
		label.text = '[k] detach'
	if global.type == 'none':
		hurtb_collision_shape_2d_2.disabled = true
		collision_shape_2d.disabled = false
		collision_shape_2d_2.disabled = true
		print('1')
		sprite_2d.show()
		sprite_2d_2.hide()
		sprite_2d_3.hide()
	animationTree.active = true
	handleCollision()
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			pass
		ATTACK:
			attack_state(delta)
			
  
  
func move_state(delta):

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	input_vector.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()

	if input_vector != Vector2.ZERO:
		animationTree.set('parameters/Idle/blend_position', input_vector)
		animationTree.set('parameters/Run/blend_position', input_vector)
		animationTree.set('parameters/Attack/blend_position', input_vector)
		animationState.travel('Run')
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel('Idle')
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	move_and_slide()
  
	if Input.is_action_just_pressed('attack'):
		state = ATTACK

func attack_state(delta):
	velocity = Vector2.ZERO
	animationState.travel('Attack')
  
func attack_animation_finished():
	state = MOVE
  

func handleCollision():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
	

func _on_area_2d_body_entered(body):
	if body.is_in_group('collectible'):
		currentLevel.update_ui_score(body.value)
		audio_stream_player_2d_2.play()
		body.collect(inventory)


func _on_hurt_box_area_entered(area):
	#if area.has_method('collect'):
		#area.collect(inventory)
	if area.name == 'HitBox':
		if !global.invisible:
			audio_stream_player_2d.play()
			camera_shake = true
			hitflashanimation.play("Hit_flash")
		



func _on_hurt_box_area_exited(area):
	camera_shake = false
