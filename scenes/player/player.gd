extends CharacterBody2D
@onready var jump_sfx = $JumpSFX

const SPEED = 250.0
const JUMP_VELOCITY = -350.0
const GRAVITY = 1200.0 # Heavy gravity so the player falls fast and snappy

func _physics_process(delta):
	# Apply Gravity
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle Jump (Single-tap)
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sfx.play()
		
	# Variable Jump Height (let go early for a shorter jump)
	if Input.is_action_just_released("jump") and velocity.y < 0:
		velocity.y *= 0.5

	# Handle Movement
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
