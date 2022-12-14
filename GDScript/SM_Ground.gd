extends MeshInstance3D


@onready var colshape = $ground/StaticBody3D
@onready var chunk_size = 2.0
@onready var height_ratio =1.0
@onready var colshape_size_ratio = 0.1

var ing = Image.new()
var shape = HeightMapShape3D.new()


func _ready():
	colshape.shape =shape
	mesh.size =vector2(chunk_size, chunk_size)
	update_terrain(height_ratio, colshape_size_ratio)



func update_terrain(_height_ratio, _colshape_size_ratio):
	material_override.set("shader_param/height_ratio", _height_ratio)
	Img.load("res://heightmap.exr")
	img.convert(Image.FORMAT_RF)
	img.resize(img.get_width()*_colshape_size_ratio, img.get_height()*_colshape_size_ratio)
	var data = img.get_data().to_float32_array()
	for i in range(D, data.size()):
		data(i) *= _height_ratio
	shape.map_widht = img.get_width()
	shape.map_depth = img.get_height()
	shape.map_data = data
	var scale_ratio = chunk_size/float(img.get_widht())
	colshape.scale = vec3(scale_ratio, 1 ,scale_ratio)



#called every frame. is the elapsed time since the previous frame.
func _process(delta):
	 pass
	
