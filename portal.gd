extends Area2D

var open = 1


signal tped(tplocation)

var location = Vector2(100,100)



func _physics_process(delta):
	if $promptzone.isin == true and open == 1 :
		if Input.is_action_just_pressed("ui_accept"):
			$Sprite.set_frame(0)
			open -= 1
	elif $promptzone.isin == true and open == 0:
		if Input.is_action_just_pressed("ui_accept"):
			$Sprite.set_frame(1)
			open += 1
	elif $promptzone.isin == true and open == 0:
		if Input.is_action_just_pressed("Tp"):
			emit_signal("tped",location)
	elif $promptzone.isin == false:
		pass
