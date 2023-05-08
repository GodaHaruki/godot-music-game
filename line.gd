extends Node

@export var note_scene: PackedScene
@export var speed: float
@export var judgement_bar_pixel: int

@onready var line = $line
@onready var startPosition = $startPosition

func new_note(softlanding_speed: float, perfect_time: float, note_id: int):
	var note = note_scene.instantiate()
	note.position = Vector2(0, startPosition.position[0])
	note.set_info(softlanding_speed, perfect_time, note_id)
	#remove_child(get_children()[0])
	print(note.perfect_time)
	line.add_child(note)
	pass
	
func _process(_delta): 
	var now_time = Time.get_unix_time_from_system()
	# 相対座標、相対スケールが使われているから、childのスケールやサイズがおかしくなりがち
	var cs = line.get_children()
	
	for n in cs:
		n.position = Vector2(
			n.position[0],
			judgement_bar_pixel - judgement_bar_pixel * 
			speed * 
			(n.perfect_time - 
			now_time)
			)
		if now_time - n.perfect_time > 0.3:
			print("delete note")
			line.remove_child(n)
		
	
	if Input.is_action_just_pressed("bt1"):

		for note in cs:
			var perfect_time = note.perfect_time
			print("nowtime: ",now_time)
			print("perfecttime: ", perfect_time)	
			print("judgetime: ", perfect_time - now_time)
			# judge
			# perfect
			if perfect_time < now_time - 0.2 or perfect_time > now_time + 0.2:
				pass
			elif perfect_time < now_time - 0.1 or  perfect_time > now_time + 0.1:
				print("great")
			elif perfect_time < now_time - 0.05 or perfect_time > now_time + 0.05:
				print("perfect")
	# pixel - pixel * ( 1 / speed) * (perfect_time - current_time 


func _on_timer_timeout():
	print("timeouted")
	new_note(0, Time.get_unix_time_from_system() + 1, int(randi() % 100))
