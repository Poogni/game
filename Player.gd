extends KinematicBody2D


var velocity = Vector2(0,0)
var speed = 150
var gravity = 13
var status = "state"
const UP = Vector2(0,-1)
var jumppower = 400
var inertia = 35
var facing = "direction"
var offset = -30
var jumped = false
var dead = false
var ispushing = false
var bumped = false


export (int, 0, 200) var push = 150



signal boxcollided(oriented)
signal sided(faces)
signal bumpedtowall(status)


func get_leftright():
	if Input.is_action_pressed("ui_right"):
		if is_on_floor():
			$AnimationPlayer.set_speed_scale(1.5)
			$AnimationPlayer.play("Running")
		$Sprite.set_flip_h(false)
		velocity.x += speed 
		status = "running"
		facing = "right"
		emit_signal("sided",facing)

	elif Input.is_action_pressed("ui_left"):
		if is_on_floor():
			$AnimationPlayer.set_speed_scale(1.5)
			$AnimationPlayer.play("Running")
		$Sprite.set_flip_h(true)
		velocity.x -= speed 
		status = "running"
		facing = "left"
		emit_signal("sided",facing)
	elif is_on_floor():
		$AnimationPlayer.set_speed_scale(1)
		$AnimationPlayer.play("Idle")

func get_jumpinput():
	if Input.is_action_pressed("ui_up") and is_on_floor():
		jumped = true
		velocity.y -= jumppower 
		status = "jumping"


func _physics_process(delta):
	if is_on_floor():
		$Sprite.scale = lerp($Sprite.scale ,Vector2(1,1),0.1)
		if jumped:
			$Sprite.scale = Vector2(1.3,0.7)
			jumped = false
		velocity.y = 0
		get_leftright()
		get_jumpinput()
	if not is_on_floor():
		speed = lerp(speed,35,0.25)
		get_leftright()
		velocity.y += gravity
		if velocity.y > 15:
			$AnimationPlayer.play("Falling")
		elif velocity.y <= 0:
			$AnimationPlayer.play("Jumping") 

	if facing == "right":
		$RayCast2D.set_scale(Vector2(1.385,0.122))
		$wall_bumper.set_scale(Vector2(1,1))

	elif facing == "left":
		$RayCast2D.set_scale(Vector2(1.385,-0.122))
		$wall_bumper.set_scale(Vector2(-1,1))


	move_and_slide(velocity * delta * 60,UP,false,4,0.785398,false)
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("pushables"):
			collision.collider.apply_central_impulse(-collision.normal * push/0.7)


	velocity.x = lerp(velocity.x,0,0.25)
	var collided  = $RayCast2D.get_collider()
	#if collided is Pushable:
		#if facing == "right":
			#pass
		#elif facing == "left":
			#pass


	if jumped:
		$Sprite.scale =lerp($Sprite.scale,Vector2(0.9,1.1),0.1)
	
	else:
		speed = 40
	
	




func _on_Area2D_body_entered(body):
		print("You died")
		

func _on_portal_body_entered(body):
	pass


func _on_promptzone_body_entered(body):
	
	print("Entered")
	
	pass # Replace with function body.


func _on_portal_tped(tplocation):
	position.x = tplocation.x
	position.y = tplocation.y


func _on_wall_bumper_body_entered(body):
	if body.name == "TileMap":
		bumped = true
		emit_signal("bumpedtowall",bumped)
	


func _on_wall_bumper_body_exited(body):
		if body.name == "TileMap":
			bumped = false
			emit_signal("bumpedtowall",bumped)
