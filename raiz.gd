extends Node2D

const HISTORIA := """Ano de seca grande. Há três invernos não cai uma gota no sertão. O gado virou osso, o açude virou rachadura, e só o mandacaru ainda dá fruto.

Dois compadres, vaqueiros da mesma fazenda, perderam tudo: o rebanho, a roça e o crédito na bodega. Numa noite de sexta-feira, o velho benzedor do lugar avisa, baixinho:

“Na encruzilhada do carnaubal, à meia-noite, o Cão paga a quem topa jogar. Mas ele só joga uma partida. E não perdoa quem perde.”

Os dois vão, cada um com a sua fome e o seu medo. Na encruzilhada, sob a lua vermelha de poeira, encontram uma mesa de pedra e, em cima dela, um revólver enferrujado, deixado por um cangaceiro que jamais foi enterrado. Uma sombra de chapéu de couro se levanta do chão:

“Seis câmaras, uma bala. Cada um puxa por vez. Quem sobreviver leva a chuva pra casa. Quem cair... fica comigo.”

Ele deixa apenas uma concessão: cada compadre pode rezar duas vezes e empurrar o revólver para o outro sem puxar o gatilho. Depois da segunda reza, o Cão ri, e não há mais a quem recorrer."""

var tween: Tween
	
var tambor := range(0, 6)
var cão := 0
var bala: int
var vez := 0                          # 0 = primeiro compadre, 1 = segundo
var passes := [2, 2]                  # rezas restantes de cada um
var nomes := ["João Grilo", "Xicó"]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Rodar_tambor.pressed.connect(rodar_tambor)
	$Gatilho.pressed.connect(pressionar_o_gatilho)
	$Passar.pressed.connect(rezar)
	$Reiniciar.pressed.connect(iniciar_partida)
	$Reiniciar.process_mode = Node.PROCESS_MODE_ALWAYS   # funciona com o jogo pausado	
	$IntroLayer/Pular.pressed.connect(pular_intro)
	mostrar_intro()
	
func iniciar_partida():
	$Recarregar.play()
	get_tree().paused = false
	$Label.show()
	$Reiniciar.hide()
	
	$Passar.show()
	$Gatilho.show()
	$Rodar_tambor.show()
	
	bala = randi_range(0, 5)
	cão = 0
	vez = 0
	passes = [2, 2]
	$Ascii.text = ""
	$Label.text = "Meia-noite. O Cão empurra o revólver sobre a pedra.\n\"Seis câmaras, uma bala.\""
	atualizar_status()



func rodar_tambor():
	$Spin.play()
	bala = randi_range(0, 5)
	print(bala)
	
func pressionar_o_gatilho():
	print (tambor[cão])

	if cão == bala:
		$SomTiro.play()
		$Ascii.text = """
		                                          
                       uuuuuuuuuuuuuuuuuuuuu.
                   .u$$$$$$$$$$$$$$$$$$$$$$$$$$W.
                 u$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$Wu.
               $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$i
              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
         `    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
           .i$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$i
           $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$W
          .$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$W
         .$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$i
         #$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$.
         W$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$u       #$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$~
$#      `"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$i        $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$        #$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
$$         $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
#$.        $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$#
 $$      $iW$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$!
 $$i      $$$$$$$#"" `"$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$W$$$$$$$$$$
 #$$W    `$$$#"            "       !$$$$$`           `"#$$$$$$$$$$#
  $$$     ``                 ! !iuW$$$$$                 #$$$$$$$#
  #$$    $u                  $   $$$$$$$                  $$$$$$$~
   #    #$$i.               #   $$$$$$$.                 `$$$$$$
          $$$$$i.                "$$$$i.               .$$$$
"          $$$$$$$$!         .   `    $$$$$$$$$i           $$$$$"
          `$$$$$  $iWW   .uW`        #$$$$$$$$$W.       .$$$$$$#
            "#$$$$$$$$$$$$#`          $$$$$$$$$$$iWiuuuW$$$$$$$$W
               !#""    ""             `$$$$$$$##$$$$$$$$$$$$$$$$
          i$$$$    .                   !$$$$$$ .$$$$$$$$$$$$$$$#
         $$$$$$$$$$`                    $$$$$$$$$Wi$$$$$$#"#$$`
         #$$$$$$$$$W.                   $$$$$$$$$$$#   ``
          `$$$$##$$$$!       i$u.  $. .i$$$$$$$$$#""
             "     `#W       $$$$$$$$$$$$$$$$$$$`      u$#
                            W$$$$$$$$$$$$$$$$$$      $$$$W
                            $$`!$$$##$$$$``$$$$      $$$$!
                           i$ $$$$  $$#`           W$$$$
                                                   W$$$$!
   
             ..  !   #$$$$$$$$$$##$$$$$$$$$$$$$$$$$$$$#
             $$W  $     "#$$$$$$$iW$$$$$$$$$$$$$$$$$$$$$W
             $#`   `       ""#$$$$$$$$$$$$$$$$$$$$$$$$$$$
                              !$$$$$$$$$$$$$$$$$$$$$#`
                              $$$$$$$$$$$$$$$$$$$$$$!
                            $$$$$$$$$$$$$$$$$$$$$$$`
                             $$$$$$$$$$$$$$$$$$$$"         
		
		"""
		$Status.text = "%s foi levado pelo Cão!" % nomes[vez]
		$Reiniciar.show()
		$Passar.hide()
		$Gatilho.hide()
		$Rodar_tambor.hide()
		
		$Label.hide()

		get_tree().paused = true
	else:
		$DryFire.play()
		cão = wrapi(cão + 1, 0, tambor.size())
		$Label.text = "Clique... %s sobreviveu." % nomes[vez]
		trocar_vez()
		
func rezar():
	if passes[vez] <= 0:
		return
	passes[vez] -= 1
	$Label.text = "%s reza e empurra o revólver..." % nomes[vez]
	trocar_vez()

func trocar_vez():
	vez = 1 - vez
	atualizar_status()

func atualizar_status():
	$Status.text = "Vez de %s | Rezas: %d" % [nomes[vez], passes[vez]]
	$Passar.disabled = passes[vez] <= 0
	
func mostrar_intro():
	$IntroLayer.show()
	$IntroLayer/TextoIntro.text = HISTORIA
	$IntroLayer/TextoIntro.visible_ratio = 0.0
	$IntroLayer/Pular.text = "Pular"
	tween = create_tween()
	tween.tween_property($IntroLayer/TextoIntro, "visible_ratio", 1.0, HISTORIA.length() * 0.03)
	tween.finished.connect(intro_terminou)

func intro_terminou():
	$IntroLayer/Pular.text = "Começar"

func pular_intro():
	if tween and tween.is_running():
		tween.kill()
		$IntroLayer/TextoIntro.visible_ratio = 1.0
		intro_terminou()
	else:
		$IntroLayer.hide()
		iniciar_partida()

func _input(event: InputEvent) -> void:
	if $IntroLayer.visible and event.is_action_pressed("ui_accept"):
		pular_intro()
		get_viewport().set_input_as_handled()

	
