extends Control

@export var cardPicture:Texture2D
@export var cardName: String
@export var cardNim: String
@onready var texture_rect: TextureRect = $background/MarginContainer/VBoxContainer/MarginContainer/TextureRect
@onready var name_label: Label = $background/MarginContainer/VBoxContainer/GridContainer/nameLabel
@onready var nim_label: Label = $background/MarginContainer/VBoxContainer/GridContainer/nimLabel

func _ready() -> void:
	texture_rect.texture = cardPicture
	name_label.text = cardName
	nim_label.text = cardNim
