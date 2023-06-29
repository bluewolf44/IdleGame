extends Resource
class_name Result

var name : String
var numb : float
var color : Color

func _init(name:String,numb:float,color:=Color("ffffff"))->void:
	self.name = name
	self.numb = numb
	self.color = color
