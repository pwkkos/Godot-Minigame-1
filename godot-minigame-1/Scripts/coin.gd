extends Area3D

const SPEED = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(SPEED * delta)


func _on_body_shape_entered(body_rid: RID, body: Node3D, body_shape_index: int, local_shape_index: int) -> void:
	var player := body as Player
	if player != null:
		player._hitCoin()
		queue_free()
