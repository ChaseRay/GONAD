extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -325.0
var count = 0
var push_force = 20.0

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var jump = $Jump
@onready var walk = $Walk


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	count += 1
	
	if (count == 15):
		animated_sprite_2d.animation = "default"
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if (velocity.x > 1 || velocity.x < -1):
			animated_sprite_2d.animation = "walk"
			if !walk.playing:
				walk.play()
		else:
			animated_sprite_2d.animation = "idle"
			walk.stop()
			
	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		animated_sprite_2d.animation = "jump"
		if walk.playing:
				walk.stop()
		jump.play()
		velocity.y = JUMP_VELOCITY
		count = 0
	for i in get_slide_collision_count():
		var c = get_slide_collision(i)
		if c.get_collider() is RigidBody2D:
			c.get_collider().apply_central_impulse(-c.get_normal() * push_force)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var facingLeft = velocity.x < 0
	var facingRight = velocity.x > 0
	
	if facingLeft:
		animated_sprite_2d.flip_h = true
	elif facingRight:
		animated_sprite_2d.flip_h = false

	move_and_slide()
	

	
