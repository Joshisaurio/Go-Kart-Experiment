extends Camera3D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var followpos : Vector3 = get_tree().get_first_node_in_group("CameraFollow").position
	position = Vector3(followpos.x-0.032, followpos.y+0.803, followpos.z+0.83)
