extends CharacterBody2D


@export var id = "alex"
@export var speed = 50
@export var limit = 0.5
@export var FRICTION = 30
@onready var endPoint = $Marker2D

@onready var playerDetectionZone = $PlayerDetectionZone
@onready var playerDeathZone = $PlayerDeathZone
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var PlayerDetectionZone = $PlayerDetectionZone/CollisionPolygon2D
@onready var PlayerDeathZone = $PlayerDeathZone/CollisionPolygon2D

@onready var passed = false

enum {
	IDLE,
	WANDER,
	CHASE
}

@onready var animations = $AnimationPlayer
@onready var animationTree : AnimationTree = $AnimationTree
@onready var animationState = animationTree.get('parameters/playback')


var startPosition
var endPosition
var state = CHASE

func _ready():
	if not passed:
		for child in get_children():
			if child.name != "Timer":
				print(child) 
				child.process_mode=4
	audio_stream_player_2d.play()
	startPosition = position
	endPosition = endPoint.global_position
	
func changeDirection():
	audio_stream_player_2d.play()
	var tempEnd = endPosition
	endPosition = startPosition
	startPosition = tempEnd
	
func changeDirectionToPlayer():
	audio_stream_player_2d.play()
	var player = playerDetectionZone.player
	var tempEnd = player.global_position
	player.global_position = startPosition
	startPosition = tempEnd
	
func updateVelocity():
	var moveDirection = (endPosition - position)
	if moveDirection.length() < limit:
		position = endPosition
		changeDirection()
		
	velocity = moveDirection.normalized() * speed

func updateAnimation():
	
	if velocity != Vector2.ZERO:
		animationTree.set('parameters/walk/blend_position', velocity)
		animationState.travel('walk')
	
func _physics_process(delta):
	$Label.text=id
	updateVelocity()
	if global.detectzone:
		PlayerDetectionZone.disabled = true
	else:
		PlayerDetectionZone.disabled = false
	if global.deathzone:
		PlayerDeathZone.disabled = true
	else:
		PlayerDeathZone.disabled = false
	
	
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player()
		WANDER:
			pass
		CHASE:
			var player = playerDetectionZone.player
		
			if player != null:
				var moveDirection = (player.global_position - global_position).normalized()
				if moveDirection.length() < limit:
					changeDirectionToPlayer()

				velocity = moveDirection.normalized() * 85
				
	updateAnimation()
	move_and_slide()
		
func seek_player():
	if playerDetectionZone.can_detect_player():
		state = CHASE


func _on_timer_timeout():
	passed=true
	for child in get_children():
		if child.name != "Timer":
			print(child) 
			child.process_mode=0
	pass # Replace with function body.
