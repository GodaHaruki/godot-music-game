extends Node

@export var note_scene: PackedScene
@export var speed: float
@export var pixel: int

func new_note(softlanding_speed: float, perfect_time: float, note_id: int):
	var note = note_scene.instantiate()
	note.position = Vector2(0, $startPosition.position[0])
	note.set_info(softlanding_speed, perfect_time, note_id)
	#remove_child(get_children()[0])
	print(note.perfect_time)
	$line.add_child(note)
	pass
	
func _process(_delta): 
	# 相対座標、相対スケールが使われているから、childのスケールやサイズがおかしくなりがち
	
	
	var cs = $line.get_children()
	#print(cs)
	for n in cs:
		#print(pixel - pixel * (1 / speed) * (n.perfect_time - float(time)))
		n.position = Vector2(
			n.position[0],
			pixel + pixel * 
			speed * 
			(n.perfect_time - 
			Time.get_unix_time_from_system())
			)
		
	# pixel - pixel * ( 1 / speed) * (perfect_time - current_time 


func _on_timer_timeout():
	print("timeouted")
	print($line.get_child_count())
	new_note(0, Time.get_unix_time_from_system() + 1, int(randi() % 100))
