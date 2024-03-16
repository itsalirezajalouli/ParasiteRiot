extends Camera2D

@export var randomStrength: float = 1.0
@export var shakeFade: float = 3.0
@onready var player = $".."

var rng = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func apply_shake():
	shake_strength = randomStrength
	
func _process(delta):
	if player.camera_shake:
		apply_shake()

	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shakeFade * delta)
		
		offset = randomOffset()
	
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength,shake_strength), rng.randf_range(-shake_strength,shake_strength))
	
	
