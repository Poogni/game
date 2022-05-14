extends StaticBody2D

onready var player_node = get_tree().get_nodes_in_group("Player").front()
onready var player = "res://Player.tscn"


var free = false
var pos2snap 
var detection
var hasplayed = 0
var isin 
var counter = 1
var countersec = 1

signal trigger(isinvalue)
signal leftvision()
signal regainedvision()



func ray_spot():
	$Detector.look_at(player_node.global_position)

func camera_off():
	$turretpupil/AnimationPlayer.play("deactivate")

func camera_on():
	$turretpupil/AnimationPlayer.play("activate")

func track():
	$turretpupil.look_at(player_node.global_position)


func _physics_process(delta):
	
	var collided = $Detector/line.get_collider()
	var detected = 0
	$Detector.look_at(player_node.global_position)
	
	
	if counter > 1:
		counter = 1

	if countersec > 1:
		counter = 1

	if not collided == player_node:
		detected  == 0
	elif collided == player_node:
		detected += 1

	if isin == 1 and detected == 1:
		
		counter = 1
		print()
		track()
		if countersec ==1:
			
			emit_signal("regainedvision")
			countersec -=1
		detection = detected
	
	elif isin == 1 and detected == 0 :
		if counter == 1:
			emit_signal("leftvision")
			counter -= 1
		countersec =1


func _on_detection_area_body_entered(body):
	var innit = 1
	print(str(body.name) + " ENTERED")
	if body.name == "Player":
		if counter == 1:
			counter += 1
			camera_on()
			emit_signal("trigger",innit)
		elif counter == 0:
			emit_signal("trigger",innit)

func _on_detection_area_body_exited(body):
	var innit = 0
	#print("Leaving")
	if body.name == "Player":
		camera_off()
		emit_signal("trigger",innit)
		countersec += 1

func _on_Turret_Base_trigger(isinvalue):
	isin = isinvalue

func _on_Turret_Base_leftvision():
	print("left vission")
	camera_off()

func _on_Turret_Base_regainedvision():
	print("Regained")
	camera_on()
	counter += 1
