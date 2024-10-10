extends RigidBody3D

signal target_hit

func _on_body_entered(_body: Node) -> void:
	if _body.is_in_group("CannonBall"):
		target_hit.emit()
