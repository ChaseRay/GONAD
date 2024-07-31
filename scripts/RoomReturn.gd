extends Area2D

var space = false
@onready var animation_player = $PortalTeleport/AnimationPlayer
@onready var portal = $Portal

func _on_body_entered(_body: PhysicsBody2D):
	space = true # Replace with function body.


func _on_body_exited(_body):
	space = false 
	
func _physics_process(_delta):
	if space == true:
		if Input.is_action_just_pressed("ui_select"):
			animation_player.play("teleport")
			portal.play()
			await get_tree().create_timer(0.7).timeout
			get_tree().change_scene_to_file("res://scenes/MainRoomScene.tscn")
