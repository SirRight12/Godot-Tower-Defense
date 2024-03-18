extends Node
class_name MoneyManager
@export var starting_amount:int = 100
@export var money_display:Label
var amount = starting_amount
func add(amt):
	amount += amt
	money_display.text = "$" + str(amount)
func sub(amt):
	amount -= amt
	money_display.text = "$" + str(amount)
func request_purchase(price):
	if price <= amount:
		money_display.text = "Can't Buy"
		sub(price)
		return true
	money_display.text = "Can Buy"
	return false
