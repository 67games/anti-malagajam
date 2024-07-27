extends TileMap

@onready var tile_map = $"."
@onready var cursor = %Cursor

var tattoo_layer = 1

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass


func _input(_event):
	
	if Input.is_action_pressed("click"):
		
		var tile_mouse_pos = tile_map.local_to_map(cursor.position)
		
		#Sustituir con las coordenadas correctas del tile del atlas
		var atlas_cord = Vector2i(1,0)
		
		tile_map.set_cell(tattoo_layer, tile_mouse_pos, 0, atlas_cord)
		
		var coincidences = (coincidence(tile_map.get_used_cells(0), tile_map.get_used_cells(1)).size() * 100) / tile_map.get_used_cells(0).size()
		
		var differences = ((difference(tile_map.get_used_cells(1), tile_map.get_used_cells(0)).size() * 100) / tile_map.get_used_cells(0).size()) * 0.25
		
		print("current score: ", coincidences - differences if coincidences - differences > 0 else 0, "%")
		pass
		
func coincidence(arr1, arr2):
	var coincidences = []
	for v in arr1:
		if (v in arr2):
			coincidences.append(v)
	return coincidences
	
func difference(arr1, arr2):
	var differences = []
	for v in arr1:
		if not (v in arr2):
			differences.append(v)
	return differences
