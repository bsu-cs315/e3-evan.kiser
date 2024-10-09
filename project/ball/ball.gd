extends RigidBody3D

var _bottom_limit:= -5.0

func _on_sleeping_state_changed() -> void:
	emit_signal("projectile_sleeping_state_changed", is_sleeping)


#func _process(_delta):
	#if global_position.y > _bottom_limit:
		#queue_free()
