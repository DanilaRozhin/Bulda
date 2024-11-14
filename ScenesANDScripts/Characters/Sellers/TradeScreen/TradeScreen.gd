extends Control

@onready var tradeScreen = $CanvasLayer
@onready var information = $CanvasLayer/Interface/UpperPanel/Information/Information

@onready var labelNumberGreenPoints = $"CanvasLayer/Interface/UpperPanel/Coins&Points/GreenPoints/NumberGreenPoints"
@onready var labelNumberBluePoints = $"CanvasLayer/Interface/UpperPanel/Coins&Points/BluePoints/NumberBluePoints"
@onready var labelNumberSilverCoins = $"CanvasLayer/Interface/UpperPanel/Coins&Points/SilverCoins/NumberSilverCoins"
@onready var labelNumberGoldCoins = $"CanvasLayer/Interface/UpperPanel/Coins&Points/GoldCoins/NumberGoldCoins"

@onready var firstTradeNumberSilverCoins = int($CanvasLayer/Interface/MarginsTrades/ScrollTrades/Trades/FirstTrade/Trade/SilverCoins/NumberSilverCoins.text)
@onready var firstTradeNumberGreenPoints = int($CanvasLayer/Interface/MarginsTrades/ScrollTrades/Trades/FirstTrade/Trade/GreenPoints/NumberGreenPoints.text)

@onready var secondTradeNumberGoldCoins = int($CanvasLayer/Interface/MarginsTrades/ScrollTrades/Trades/SecondTrade/Trade/GoldCoins/NumberGoldCoins.text)
@onready var secondTradeNumberBluePoints = int($CanvasLayer/Interface/MarginsTrades/ScrollTrades/Trades/SecondTrade/Trade/BluePoints/NumberBluePoints.text)

@onready var thirdTradeNumberSilverCoins = int($CanvasLayer/Interface/MarginsTrades/ScrollTrades/Trades/ThirdTrade/Trade/SilverCoins/NumberSilverCoins.text)
@onready var thirdTradeNumberGoldCoins = int($CanvasLayer/Interface/MarginsTrades/ScrollTrades/Trades/ThirdTrade/Trade/GoldCoins/NumberGoldCoins.text)

@onready var soundAccept = $Accept

var numberGreenPoints
var numberBluePoints
var numberSilverCoins
var numberGoldCoins



func _ready():
	soundAccept.volume_db = GlobalSettings.volumeSounds
	
	if "Player" in str(get_parent()):
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		show_trade_screen()
		return
	
	process_mode = Node.PROCESS_MODE_INHERIT
	tradeScreen.hide()



func update_labels() -> void:
	labelNumberGreenPoints.text = str(numberGreenPoints)
	labelNumberBluePoints.text = str(numberBluePoints)
	labelNumberSilverCoins.text = str(numberSilverCoins)
	labelNumberGoldCoins.text = str(numberGoldCoins)
	
	
func update_global() -> void:
	GlobalPlayer.numberGreenPoints = numberGreenPoints
	GlobalPlayer.numberBluePoints = numberBluePoints
	GlobalPlayer.numberSilverCoins = numberSilverCoins
	GlobalPlayer.numberGoldCoins = numberGoldCoins
	

func update_local() -> void:
	numberGreenPoints = GlobalPlayer.numberGreenPoints
	numberBluePoints = GlobalPlayer.numberBluePoints
	numberSilverCoins = GlobalPlayer.numberSilverCoins
	numberGoldCoins = GlobalPlayer.numberGoldCoins


func show_trade_screen() -> void:
	update_local()	
	update_labels()
	information.text = " "
	tradeScreen.show()


func hide_trade_screen() -> void:
	update_global()
	GlobalPlayer.save_data()
	
	if "Player" in str(get_parent()):
		get_parent().get_node("Stats").show_stats()
		get_parent().get_node("Interface").show_interface()
		get_parent().update_stats("Global")
		get_tree().paused = false
		queue_free()


func successful_tade() -> void:
	information.set("theme_override_colors/font_color", Color(0, 1, 0))
	information.text = "Обмен произведён успешно"


func unsuccessful_trade(text) -> void:
	information.set("theme_override_colors/font_color", Color("dc0000"))
	information.text = text



func _on_accept_first_trade_pressed():
	if not numberSilverCoins >= firstTradeNumberSilverCoins:
		unsuccessful_trade("У вас недостаточно серебряных монет")
		return
	
	numberSilverCoins -= firstTradeNumberSilverCoins
	numberGreenPoints += firstTradeNumberGreenPoints
	update_labels()
	successful_tade()
	soundAccept.play()


func _on_accept_second_trade_pressed():
	if not numberGoldCoins >= secondTradeNumberGoldCoins:
		unsuccessful_trade("У вас недостаточно золотых монет")
		return
	
	numberGoldCoins -= secondTradeNumberGoldCoins
	numberBluePoints += secondTradeNumberBluePoints
	update_labels()
	successful_tade()
	soundAccept.play()


func _on_accept_third_trade_pressed():
	if !(numberSilverCoins >= thirdTradeNumberSilverCoins):
		unsuccessful_trade("У вас недостаточно серебряных монет")
		return
		
	numberSilverCoins -= thirdTradeNumberSilverCoins
	numberGoldCoins += thirdTradeNumberGoldCoins
	update_labels()
	successful_tade()
	soundAccept.play()


func _on_close_trade_screen_pressed():
	hide_trade_screen()
