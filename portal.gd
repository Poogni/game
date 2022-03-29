extends Area2D

var open = 1


signal tped(tplocation)

var location = Vector2(100,100)



func _physics_process(delta):
	print(open)
	if $promptzone.isin == true and open == 1 :
		if Input.is_action_just_pressed("ui_accept"):
			$Sprite.set_frame(0)
			open -= 1
			
		else:
			pass
	elif $promptzone.isin == true and open == 0:
		if Input.is_action_just_pressed("ui_accept"):
			$Sprite.set_frame(1)
			open += 1
		else:
			pass
	elif $promptzone.isin == false:
		pass
		print(" Not Interactable ")
