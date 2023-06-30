extends Control

func _ready()->void:
	Main.current_scene = self
	$ProgressBar.max_value = Main.xp_need
	$Button.button_up.connect(Main.level_up)
	$Label.text = str(Main.total_xp-Main.pre_xp).pad_decimals(2) + "/" + str(Main.xp_need).pad_decimals(2)
	$Tasks.button_up.connect(get_tree().change_scene_to_file.bind("res://Scenes/TasksRoom/Tasks_room.tscn"))
	$Building.button_up.connect(get_tree().change_scene_to_file.bind("res://Scenes/BuildingRoom/Building_room.tscn"))
	
	if(Main.level>=1):
		$Tasks.visible = true
	
	if(Main.level>=2):
		$Building.visible = true
	

func update()->void:
	$ProgressBar.value = Main.total_xp
	$Label.text = str(Main.total_xp-Main.pre_xp).pad_decimals(2) + "/" + str(Main.xp_need).pad_decimals(2)
	if(Main.xp_need<Main.total_xp):
		$CPUParticles2D.emitting = true
		$Button.visible = true
	
func level_up()->void:
	$CPUParticles2D.emitting = false
	$Button.visible = false
	$ProgressBar.min_value = Main.pre_xp
	$ProgressBar.max_value = Main.xp_need
	
	if(Main.level>=1):
		$Tasks.visible = true
	
	if(Main.level>=2):
		$Building.visible = true
