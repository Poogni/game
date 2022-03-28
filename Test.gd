extends KinematicBody2D



func _physics_process(delta):
	 look_at(get_parent().get_node("YSort/Player").position)





# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
