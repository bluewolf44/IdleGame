extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	Main.current_scene = self
	$%Level.button_up.connect(get_tree().change_scene_to_file.bind("res://Scenes/LevelUpRoom/Level_up_room.tscn"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func update()->void:
	pass
