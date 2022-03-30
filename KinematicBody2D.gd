extends KinematicBody2D



var velocity = Vector2(0,0)
var speed = 100
var gravity = 13
var status = "state"
const UP = Vector2(0,-1)
var jumppower = 300
var inertia = 35
var facing = "direction"
var offset = -30
var jumped = false
var dead = false



func get_leftright():
	if Input.is_action_pressed("ui_right"):
		if is_on_floor():
			$AnimationPlayer.set_speed_scale(1.5)
			$AnimationPlayer.play("Running")
		$Sprite.set_flip_h(false)
		velocity.x += speed
		status = "running"
		facing = "right"

	elif Input.is_action_pressed("ui_left"):
		if is_on_floor():
			$AnimationPlayer.set_speed_scale(1.5)
			$AnimationPlayer.play("Running")
		$Sprite.set_flip_h(true)
		velocity.x -= speed
		status = "running"
		facing = "left"
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
	elif facing == "left":
		$RayCast2D.set_scale(Vector2(1.385,-0.122))

	move_and_slide(velocity * delta * 60,UP,false,4,0.785398,false)
	velocity.x = lerp(velocity.x,0,0.25)
	var collided  = $RayCast2D.get_collider()
	if collided is MovableBlock:
		if facing == "right":
			collided.apply_central_impulse(Vector2(1800,25))
		elif facing == "left":
			collided.apply_central_impulse(Vector2(-1800,25))

	if jumped:
		$Sprite.scale =lerp($Sprite.scale,Vector2(0.9,1.1),0.1)
			
	
	else:
		speed = 37.5
	



func _on_Area2D_body_entered(body):
		print("ENTERED")
		

func _on_portal_body_entered(body):
	pass


func _on_promptzone_body_entered(body):
	
	print("Entered")
	
	pass # Replace with function body.


func _on_portal_tped(tplocation):
	position.x = tplocation.x
	position.y = tplocation.y
