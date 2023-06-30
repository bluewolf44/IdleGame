extends Node2D

var speed : Vector2i

func create(text:String,color:Color,p:Vector2,speed:Vector2i):
	self.speed = speed
	$Label.text = text
	position = p
	modulate = color
	await get_tree().create_timer(randi_range(3,6)).timeout
	queue_free()

func _process(delta):
	position += speed*delta
