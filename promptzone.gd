extends Area2D


var isin = false





func _on_promptzone_body_entered(body):
	
	isin = true
	
	$prompt/AnimationPlayer.play("New Anim")
	
	print("BOdy entered on that other node")
	
	
	
	
	pass 


func _on_promptzone_body_exited(body):
	
	$prompt/AnimationPlayer.play_backwards("New Anim")
	
	isin = false
	
	pass # Replace with function body.
	
	

