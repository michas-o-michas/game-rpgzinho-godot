extends Area2D

@onready var preview = $Preview
@onready var labelName = $LabelName

@export var texture: Resource
@export var itemName : String
@export var quantity : int

func _ready():
	preview.texture = texture
	labelName.text  = itemName

