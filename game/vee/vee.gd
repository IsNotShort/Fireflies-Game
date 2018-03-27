extends Area2D

const CATCHING_SHOW_TIME = 0.70

export (int) var SPEED
var velocity = Vector2()
var screensize

var colliding = false
var firefly_col
var score = 0
var catch_time = 9999

var anim=""

func _ready():
	screensize = get_viewport_rect().size

func _process(delta):
	var new_anim = "idle_front"
	
	catch_time += delta
	
	velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		new_anim = "walk_right"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		new_anim = "walk_left"
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		new_anim = "walk_front"
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		new_anim = "walk_back"
	if velocity.length() > 0:
		velocity = velocity.normalized() * SPEED
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if Input.is_action_pressed("catch"):
		pass
	
	if colliding == true:
		if Input.is_action_just_released("catch"):
			score += 1
			print(score)
			$anim.play("catch")
			catch_time = 0
			firefly_col.queue_free()
			
	if catch_time < CATCHING_SHOW_TIME:
		new_anim += "catch"
	
	if new_anim != anim:
		anim = new_anim
		$anim.play(anim)

func _on_vee_body_entered( body ):
	colliding = true
	firefly_col = body

func _on_vee_body_exited( body ):
	colliding = false