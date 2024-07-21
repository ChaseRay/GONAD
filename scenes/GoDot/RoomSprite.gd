extends Sprite2D


func _ready():
	if texture:
		size()
	
func size():
	var roomsize = Vector2(1920,1080)
	var texturesize = texture.get_size()
	if texturesize != Vector2.ZERO:
		scale = roomsize / texturesize
