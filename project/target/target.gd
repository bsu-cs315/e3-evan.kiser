extends RigidBody3D

@export var winDetector = false

func _on_body_entered(_body: Node) -> void:
	winDetector = true
