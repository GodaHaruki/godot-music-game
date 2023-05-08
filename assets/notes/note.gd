extends Sprite2D

class_name Note

var softlanding_speed: float = 0
var perfect_time: float
var note_id: int

#func from(softlan: float, p_time: float, id: int) -> Note:

func set_info(softlan: float, p_time: float, id: int):
	self.softlanding_speed = softlan
	self.perfect_time = p_time
	self.note_id = id
	


func _on_visible_on_screen_notifier_2d_screen_exited():
	print(position)
	queue_free()
