extends Node

export (PackedScene) var mob_scene


func _ready():
	randomize() 


func _on_MobTimer_timeout():
	# Create new mob instance
	var mob = mob_scene.instance()
	
	# Random spawn location on the spawnPath
	# Get location from spawnlocation
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# Give a random offset
	mob_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	mob.initialize(mob_spawn_location.translation, player_position)
	
	add_child(mob)
