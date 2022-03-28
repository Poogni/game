extends RayCast2D




# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	set_cast_to(get_parent().get_parent().get_node("Duck").position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
