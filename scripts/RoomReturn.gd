extends Area2D

var space = false

func _on_body_entered(_body: PhysicsBody2D):
	space = true # Replace with function body.


func _on_body_exited(_body):
	space = false 
	
func _physics_process(_delta):
	if space == true:
		if Input.is_action_just_pressed("ui_select"):
			get_tree().change_scene_to_file("res://scenes/MainRoomScene.tscn")
