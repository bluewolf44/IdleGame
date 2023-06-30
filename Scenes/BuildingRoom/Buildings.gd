extends Resource

class_name Buildings

var name : String
var level := 0
var requirements : Array[Result]
var texture : Texture
var effect : String
var list : Control

func _init(name:String,requirements:Array[Result],texture:Texture=null):
	self.name = name
	self.requirements = requirements
	self.texture = texture
	
