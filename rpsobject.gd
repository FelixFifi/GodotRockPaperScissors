@tool
class_name RPSObject
extends RigidBody2D

enum ObjectType {
	ROCK = 0,
	PAPER = 1,
	SCISSORS = 2,
	NONE = -1
}
const TEXTURES : Array[Texture2D] = [preload("res://rock.tres"), preload("res://paper.tres"), preload("res://scissors.tres")]

@onready var sprite = %Sprite
@export var initial_speed = 500

var _type: ObjectType = ObjectType.NONE
@export var type: ObjectType = ObjectType.NONE :
	get:
		return _type
	set(new_type):
		if new_type != ObjectType.NONE and sprite != null:
			sprite.texture = TEXTURES[new_type]
		_type = new_type


func _ready():
	# Call setter again to fix sprite not changed
	type = _type
	if type == ObjectType.NONE:
		type =  randi_range(0,2) as ObjectType

	var initialDirection = Vector2.UP.rotated(randf() * 2 * PI)
	linear_velocity = initial_speed * initialDirection


func _on_body_entered(body):
	if not body is RPSObject:
		return

	var other_type: ObjectType = body.type

	if type == ObjectType.ROCK and other_type == ObjectType.PAPER:
		type = ObjectType.PAPER
	elif type == ObjectType.PAPER and other_type == ObjectType.SCISSORS:
		type = ObjectType.SCISSORS
	elif type == ObjectType.SCISSORS and other_type == ObjectType.ROCK:
		type = ObjectType.ROCK
