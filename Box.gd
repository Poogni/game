extends RigidBody2D

var pickup_able = false

onready var player_node = get_tree().get_nodes_in_group("Player").front()
onready var player = "res://Player.tscn"

var pickedup = false
var towards 
var tilemapcollided = false



func _physics_process(delta):
	var staticpos_r = Vector2(player_node.global_position.x + 27,player_node.global_position.y )
	var staticpos_l = Vector2(player_node.global_position.x - 29,player_node.global_position.y )
	var staticpos_a = Vector2(player_node.global_position.x ,player_node.global_position.y - 27 )
	if pickup_able == true:
		if Input.is_action_just_pressed("Tp"):
			pickedup = true
		elif Input.is_action_just_pressed("ui_accept"):
			pickedup = false
			
	if pickedup:
		$CollisionShape2D.disabled = true
		$box_sprite/Outline.visible = false
		if towards == "right":
			if !tilemapcollided:
				position = lerp(global_position,staticpos_r,0.28)
			elif tilemapcollided:
				position = lerp(global_position,staticpos_a,0.2)
			scale = Vector2(1,1)

		elif towards == "left":
			if !tilemapcollided:
				position = lerp(global_position,staticpos_l,0.28)
			elif tilemapcollided:
				position = lerp(global_position,staticpos_a,0.2)
			scale = Vector2(-1,1)
		mode =RigidBody2D.MODE_STATIC
		$CollisionShape2D.disabled = true
		

	elif !pickedup:
		$box_sprite/Outline.visible = true
		mode =RigidBody2D.MODE_RIGID
		$CollisionShape2D.disabled = false
	
	print(tilemapcollided)
	
	




func _on_Detectplyr_body_entered(body):
	if body.name == "Player":
		$AnimationPlayer.play("Outline_Appear")
		pickup_able = true



func _on_Detectplyr_body_exited(body):
	if body.name == "Player":
		$AnimationPlayer.play("Outline_Disappear")
		pickup_able = false
		


func _on_Player_sided(faces):
	towards = faces


#func _on_bumper_body_entered(body):
	#if body.name == "TileMap":
#		tilemapcollided = true




#func _on_bumper_body_exited(body):
	#if body.name == "TileMap":
		#tilemapcollided = false


func _on_Player_bumpedtowall(status):
	tilemapcollided = status
