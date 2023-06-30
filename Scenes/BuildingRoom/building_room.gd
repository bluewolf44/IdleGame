extends Control


func _ready():
	print("help")
	Main.current_scene = self
	$%Level.button_up.connect(get_tree().change_scene_to_file.bind("res://Scenes/LevelUpRoom/Level_up_room.tscn"))
	
	for building in Main.buildings:
		var list_instance := preload("res://Scenes/BuildingRoom/Building_list.tscn").instantiate()
		list_instance.get_node("%Name").text = building.name
		list_instance.get_node("%Level").text = "Level"+str(building.level).pad_zeros(3)
		list_instance.get_node("%Image").texture = building.texture
		list_instance.get_node("%Button").button_up.connect(Main.build_building.bind(building))
		list_instance.mouse_entered.connect(mouse_input.bind(building))
		list_instance.mouse_exited.connect(mouse_exit)
		for req in building.requirements:
			var label = Label.new()
			label.text = req.item.name + ":" + str(Main.items[req.item.name].numb).pad_zeros(4) + "/" + str(req.numb).pad_zeros(4)
			label.modulate = req.item.color
			list_instance.get_node("%Requirments").add_child(label)
		
		$%Box1.add_child(list_instance)
		
		building.list = list_instance

func _process(delta)-> void:
	pass

func update()->void:
	pass

func mouse_input(building:Buildings)->void:
	return
	
func mouse_exit()->void:
	return
