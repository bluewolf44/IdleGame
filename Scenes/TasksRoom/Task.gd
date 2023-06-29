extends Resource
class_name Task

var skill := 0
var name : String
var time : float
var result : Array[Result]

var current_time : float
var is_running := false
var list : Control


func _init(name:String,time:float,result:Array[Result]) -> void:
	self.name = name
	self.time = time
	self.result = result
	self.current_time = time
