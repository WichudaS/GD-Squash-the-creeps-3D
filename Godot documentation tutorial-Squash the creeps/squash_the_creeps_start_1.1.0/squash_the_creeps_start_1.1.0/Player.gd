extends KinematicBody

# How fast the player moves in meters per second
export var speed = 14
#The downward acceleration when in the air, in meters per second squared.
export var fall_acceleration = 75
# Vertical impulse applied to the character upon jumping in meters per second.
export var jump_impulse = 20
# Vertical impulse applied to the character upon bouncing over a mob in
# meters per second.
export var bounce_impulse = 16

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
	
	#Jumping
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y += jump_impulse
	
	# Moving the character
	velocity = move_and_slide(velocity, Vector3.UP)
	
	# Kill mob and bounce
	for index in range(get_slide_count()):
		# Check every collision that occurred in this frame
		var collision = get_slide_collision(index)
		# If we collide with a monster
		if collision.collider.is_in_group("mob"):
			var mob = collision.collider
			# Check that we hitting it from above?
			if Vector3.UP.dot(collision.normal) > 0.1:
				# Squash and bounce
				mob.squash()
				velocity.y = bounce_impulse


