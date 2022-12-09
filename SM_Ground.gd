extends MeshInstance3D

@onready var colshape = $StaticBody3D/CollisionShape3D
@onready var chunk_size = 2.0
@onready var height_ratio = 1.0
@onready var colshape_size_ratio = 0.1


var image = Image.new()
var shape = HeightMapShape3D.new()


func _ready():
	colshape.shape = shape
	mesh.size = Vector2(chunk_size, chunk_size)
	update_terrain(height_ratio, colshape_size_ratio)


func update_terrain(_height_ratio, _colshape_size_ratio):
	material_overlay.set("shadar_param/height_ratio", _height_ratio)
	image.load("res://Textures/Textures_DessertTerrain/Textures_DessertTerrain/Dessert_Color.png")
	image.convert(Image.FORMAT_RF)
	image.resize(image.get_width()*_colshape_size_ratio, image.get_height()*_colshape_size_ratio)
	var data = image.get_data().to_float32_array()
	for i in range(0, data.size()):
		data[i] *= _height_ratio
	shape.map_width = image.get_height()
	shape.map_depth = image.get_height()
	shape.map_data  = data
	colshape.shape = shape
	var scale_ratio = chunk_size/float(image.get_width())
	colshape.scale = Vector3(scale_ratio, 1 , scale_ratio)
	
func _process(delta):
	pass
