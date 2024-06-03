class_name CountDownTimmer

var count_time: float;
var is_repeat: bool;
var action_func;

var time_counter = 0.0;
var is_active = false;

func _init(_count_time, _action_func, _is_repeat):
	count_time = count_time
	action_func = action_func
	is_repeat = is_repeat
	pass

#============================
func update(_dt):
	if count_time < 0 || !is_active :
		return
		
	time_counter += _dt
	if time_counter >= count_time:
		time_counter = 0.0
		is_active = is_repeat
		action_func.call()
	pass

func stop():
	is_active = false
	time_counter = 0.0
	
func pause():
	is_active = false

func resume():
	is_active = true

func set_repeat(_enable_repeat):
	is_repeat = _enable_repeat
	
func do_action():
	action_func.call()
#============================
