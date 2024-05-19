class_name StateMachine

const STATE_NONE = -1
enum {ON_ENTER, ON_UPDATE, ON_EXIT}

var current_state_id = STATE_NONE
var each_state_funcs = {}

func _init():
	each_state_funcs[STATE_NONE] = _generate_empty_state_func()
	pass
	
#=========================[Public]============================

func add_state(state_id, state_funcs):
	var reault_state_funcs = _generate_empty_state_func()
	for act in state_funcs:
		reault_state_funcs[act] = state_funcs[act]
	
	each_state_funcs[state_id] = reault_state_funcs
	pass

# 一批量添加
func add_state_batch(state_funcs_table):
	for state_id in state_funcs_table:
		add_state(state_id, state_funcs_table[state_id])
	pass
	
func transfer(target_state_id):
	each_state_funcs[current_state_id][ON_EXIT].call()
	each_state_funcs[target_state_id][ON_ENTER].call()
	current_state_id = target_state_id
	pass
	
func on_update(dt):
	if each_state_funcs[current_state_id] != null:
		each_state_funcs[current_state_id][ON_UPDATE].call(dt)
	pass

#=========================[Private]===========================
func _generate_empty_state_func():
	return {
		ON_ENTER: func():pass,
		ON_UPDATE: func(dt):pass,
		ON_EXIT: func():pass,
	}
