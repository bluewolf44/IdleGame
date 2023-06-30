extends Node

var total_xp := 0.0
var xp_need := 0.2
var pre_xp := 0.0
var level := 0

var tasks := []
var tasks_dir : Dictionary
var buildings := []
var buildings_dir : Dictionary

var items : Dictionary

var current_scene : Control

func level_up()->void:
	pre_xp = xp_need
	xp_need = xp_need*10+3
	level += 1
	
	current_scene.level_up()
	
func _process(delta:float)->void:
	var xp_per_sec := 0.1*delta
	total_xp += xp_per_sec
	
	for task in tasks:
		if !task.is_running:
			continue
		task.current_time -= delta
		if task.current_time <= 0:
			task.is_running = false
			task.current_time = task.time
			task.skill += 1
			
			if is_instance_valid(task.list):
				task.list.get_node("%Button").disabled = false
				task.list.get_node("%Button").text = "Start"
				task.list.get_node("%Time").text = Main.time_to_str(task.time)
				task.list.get_node("%ProgressBar").value = task.time
				task.list.get_node("%Skill").text = "Skill:" + str(task.skill).pad_zeros(4)
				create_text(task.result,task.list,task.list.size/2)
			add_result(task.result)
		
	current_scene.update()

func _ready()->void:
	tasks.append(Task.new(
		"Finding Rocks",5,
		[
			Result.new(add_item(Item.new("Xp",0,Color("10ade6"))),2),
			Result.new(add_item(Item.new("Rock",0,Color("b5484c"))),1)
		]
	))
	
	buildings.append(Buildings.new(
		"Obelisk",
		[
			Result.new(items["Rock"],2)
		],
		load("res://image (4).png")
	))
	
	for n in range(tasks.size()):
		tasks_dir[tasks[n].name] = n

	for n in range(buildings.size()):
		buildings_dir[buildings[n].name] = n


func time_to_str(time:float)-> String:
	var str = ""
	str += str(time/3600).pad_decimals(0).pad_zeros(2)
	str += ":"
	str += str(int(time/60)%60).pad_decimals(0).pad_zeros(2)
	str += ":"
	str += str(int(time)%3600).pad_decimals(0).pad_zeros(2)
	return str

func add_result(results:Array[Result]) -> void:
	for r in results:
		if r.item.name == "Xp":
			total_xp += r.numb
		if items.has(r.item.name):
			items[r.item.name].numb += r.numb

func remove_result(results:Array[Result])-> bool:
	if !has_items(results):
		return false
	for r in results:
		items[r.item.name].numb -= r.numb
	return true

func has_items(results:Array[Result])-> bool:
	for r in results:
		if !items.has(r.item.name):
			print("doesn't have item"+r.item.name)
			return false
		if items[r.item.name].numb < r.numb:
			return false
	return true

func create_text(results:Array[Result],node:CanvasItem,position:Vector2,speed:=Vector2i(randi_range(-5,5),randi_range(-20,-40))):
	for result in results:
		var text := preload("res://Scenes/text.tscn").instantiate()
		node.add_child(text)
		text.create(result.item.name+":"+str(result.numb),result.item.color,position,speed)
		await get_tree().create_timer(randf_range(0.3,1.0)).timeout

func add_item(item:Item)->Item:
	if items.has(item.name):
		print("overlap "+item.name)
		return item
	items[item.name] = item
	return item

func build_building(building:Buildings)-> void:
	if Main.remove_result(building.requirements):
		building.level += 1
		if is_instance_valid(building.list):
			create_text(building.requirements,building.list,building.list.position+building.list.size/2,Vector2i(randi_range(-5,5),randi_range(20,40)))
		for req in building.requirements:
			req.numb += req.numb*2 + 1
		
		if is_instance_valid(building.list):
			building.list.get_node("%Level").text = "Level"+str(building.level).pad_zeros(3)
			for n in range(1,building.list.get_node("%Requirments").get_child_count()):
				building.list.get_node("%Requirments").get_child(n).queue_free()
			
			for req in building.requirements:
				var label = Label.new()
				label.text = req.item.name + ":" + str(Main.items[req.item.name].numb).pad_zeros(4) + "/" + str(req.numb).pad_zeros(4)
				label.modulate = req.item.color
				building.list.get_node("%Requirments").add_child(label)
		
