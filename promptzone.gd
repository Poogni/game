extends Area2D


var isin = false
var player = "res://Player.tscn"


func _on_promptzone_body_entered(body):
	
	if body.name == "Player":
		isin = true
		$prompt/AnimationPlayer.play("New Anim")
		print("Body entered")
	
	
	


func _on_promptzone_body_exited(body):
	if body.name == "Player":
		$prompt/AnimationPlayer.play_backwards("New Anim")
		isin = false
	
	

