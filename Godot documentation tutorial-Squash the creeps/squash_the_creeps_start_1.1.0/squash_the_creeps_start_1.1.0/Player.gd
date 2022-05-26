extends KinematicBody

# How fast the player moves in meters per second
export var speed = 14
#The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75

var velocity = Vector3.ZERO

func _physics_process(delta):
	#store input direction
	var direction = Vector3.ZERO
	
	#check input and update direction
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	#In 3D, ground plane is XZ, not XY !!!
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	# Capped the direction length to 1 in all directions
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		# '.UP' is the looking direction to calculate coordinate. In this case UP = 'Looking from above character'
		$Pivot.look_at(translation + direction, Vector3.UP)
	
	# Let's move!	
	# Ground velocity
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	# Vertical velocity
	velocity.y -= fall_acceleration * delta
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)


