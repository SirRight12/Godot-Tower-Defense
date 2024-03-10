extends Label
class_name Console
func log_out(data):
	text += str(data)
func log_clear():
	text = ""
func log_ln():
	text += "\n"
