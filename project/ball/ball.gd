extends RigidBody3D

var _screen_bottom_limit:= -1.0

func _on_sleeping_state_changed() -> void:
	emit_signal("projectile_sleeping_state_changed", is_sleeping)


func _process(_delta):
	if position.y > _screen_bottom_limit:
		queue_free()
