extends Area3D

func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	print(body.name)
	var player := body as Player
	if player != null:
		player._respawn()
