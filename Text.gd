extends Node2D

var speed : Vector2i

func create(text:String,color:Color,p:Vector2):
	$Label.text = text
	position = p
	modulate = color
	speed = Vector2i(randi_range(-5,5),randi_range(-20,-40))
	await get_tree().create_timer(randi_range(3,6)).timeout
	queue_free()

func _process(delta):
	position += speed*delta
