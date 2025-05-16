extends Interactible3D

signal interacted
func _ready() -> void:
	add_to_group("pieces")


func _interact():
	emit_signal("interacted", self)
	var piece = $".."
	self.CanInteract = false
	$CollisionShape3D.disabled = true
	piece.hide()
