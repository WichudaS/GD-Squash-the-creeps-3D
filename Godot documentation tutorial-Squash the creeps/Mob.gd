extends KinematicBody

# Add new signal
signal squashed

# Set random speed of mobs (m/s)
export var min_speed = 10
export var max_speed = 18
var velocity = Vector3.ZERO


# Define spawning logic to be called in Main scene
func initialize(start_position, player_position):
	# Position the mob and turn it to looks at the player
	look_at_from_position(start_position, player_position, Vector3.UP)
	# And rotate it randomly so it doesn't move exactly toward the player.
	# Rotate around Y axis:
	rotate_y(rand_range(-PI/4, PI/4))
	# Calculate random speed
	var random_speed = rand_range(min_speed, max_speed)
	# Calaulate a forward velocity (speed)
	velocity = Vector3.FORWARD * random_speed
	# rotate velocity's vector to the angle it's looking.
	
	velocity = velocity.rotated(Vector3.UP, rotation.y)



# Run physsics for every frames
func _physics_process(delta):
	# warning-ignore:return_value_discarded
	move_and_slide(velocity)
# Now mob can move!


func _on_VisibilityNotifier_screen_exited():
	# Delete the instance
	queue_free()

func squash():
	emit_signal("squashed")
	queue_free()
