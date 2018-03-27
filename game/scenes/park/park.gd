extends Node2D

onready var fly = preload("res://firefly/firefly.tscn")

func _ready():
	randomize()

func game_over():
	$fly_time.stop()

func _on_fly_time_timeout():
	$fly_path/fly_spawnloc.set_offset(randi())
	var flies = fly.instance()
	add_child(flies)
	var direction = $fly_path/fly_spawnloc.rotation + PI/2
	flies.position = $fly_path/fly_spawnloc.position
	direction += rand_range(-PI/4, PI/4)
	flies.rotation = direction
	flies.set_linear_velocity(Vector2(rand_range(flies.MIN_SPEED, flies.MAX_SPEED), 0).rotated(direction))

func _on_end_time_timeout():
	get_tree().change_scene("res://gui/end_screen/end_screen.tscn")