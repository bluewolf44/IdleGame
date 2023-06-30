extends Resource
class_name Result

var item : Item
var numb : float

func _init(item:Item,numb:float)->void:
	self.item = item
	self.numb = numb
