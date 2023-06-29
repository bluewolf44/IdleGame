extends Control

func _ready() -> void:
	Main.current_scene = self
	$%Level.button_up.connect(get_tree().change_scene_to_file.bind("res://Scenes/LevelUpRoom/level_up_room.tscn"))
	
	for task in Main.tasks:
		var list_instance := preload("res://Scenes/TasksRoom/Task_List.tscn").instantiate()
		list_instance.get_node("%Name").text = task.name
		list_instance.get_node("%Skill").text = "Skill:" + str(task.skill).pad_zeros(4)
		list_instance.get_node("%Time").text = Main.time_to_str(task.time)
		list_instance.get_node("%Button").button_up.connect(start_task.bind(task))
		list_instance.get_node("%ProgressBar").max_value = task.time
		$%Box1.add_child(list_instance)
		
		task.list = list_instance

func start_task(task:Task)-> void:
	task.is_running = true
	task.list.get_node("%Button").disabled = true
	task.list.get_node("%Button").text = "in progress"

func update()->void:
	for task in Main.tasks:
		if(task.is_running):
			task.list.get_node("%Time").text = Main.time_to_str(task.current_time)
			task.list.get_node("%ProgressBar").value = task.current_time
