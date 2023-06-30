extends Node

var total_xp := 0.0
var xp_need := 0.2
var pre_xp := 0.0
var level := 0

var tasks := []
var items := {}

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
	tasks.append(Task.new("Finding Rocks",10,[Result.new("Xp",2,Color("10ade6")),Result.new("Rock",1,Color("b5484c"))]))

func time_to_str(time:float)-> String:
	var str = ""
	str += str(time/3600).pad_decimals(0).pad_zeros(2)
	str += ":"
	str += str(int(time/60)%60).pad_decimals(0).pad_zeros(2)
	str += ":"
	str += str(int(time)%3600).pad_decimals(0).pad_zeros(2)
	return str

func add_result(results:Array[Result]):
	for r in results:
		if r.name == "Xp":
			total_xp += r.numb
		if items.has(r.name):
			items[r.name] += r.numb
		else:
			items[r.name] = r.numb

func create_text(results:Array[Result],node:CanvasItem,position:Vector2):
	for result in results:
		var text := preload("res://Scenes/text.tscn").instantiate()
		node.add_child(text)
		text.create(result.name+":"+str(result.numb),result.color,position)
		await get_tree().create_timer(randf_range(0.3,1.0)).timeout
