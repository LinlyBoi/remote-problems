extends CanvasLayer

@onready var label = $TextureRect/Label
@onready var debuginfo = $DebugInfoLabel
@onready var pieces_collected = $"TextureRect/Pieces Collected"
const DEBUG_TEMPLATE = "PlayerState: {plrstate}\nPlayerSpeed: {speed}\nGlobal Coordinates (X/Y/Z): {globalpos}\nFPS: {fps}"


@onready var counter_label = $Control/PiecesCounter/Label  # Adjust path to your counter label

func _ready():
	# Find the player node and connect to its piece_collected signal
	var player = get_tree().get_first_node_in_group("player")  # Make sure your player is in "player" group
	if player:
		player.piece_collected.connect(_update_counter)
	
	# Initialize counter
	_update_counter(0)

func _update_counter(count):
	counter_label.text = str(count)

func update_text(text : String) -> void:
	label.text = text

func _input(event) -> void:
	if event.is_action_pressed("debug"):
		debuginfo.visible = !debuginfo.visible
		debugLoop()

func debugLoop():
	while debuginfo.visible:
		debuginfo.text = DEBUG_TEMPLATE.format({
			"plrstate": GameManager.player.currentState,
			"speed": GameManager.player.SPEED,
			"globalpos": GameManager.player.global_position,
			"fps": Engine.get_frames_per_second()
		})
		await get_tree().create_timer(.5).timeout
