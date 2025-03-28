class Game_Player < Game_Character
  alias old_initialize initialize

  def initialize(*args)
    old_initialize(*args)
    @sequence = []  # Lista para armazenar as teclas pressionadas
  end

  def check_key_sequence
    # Defina a sequência que o jogador deve pressionar (com letras maiúsculas para comparação)
    target_sequence = ["M", "E", "W", "T", "W", "O"]
    
    # Verifica se a tecla foi pressionada, ignorando maiúsculas e minúsculas
    if Input.trigger?(Input::M) || Input.trigger?(Input::m)   # M ou m
      @sequence.push("M")
    elsif Input.trigger?(Input::E) || Input.trigger?(Input::e) # E ou e
      @sequence.push("E")
    elsif Input.trigger?(Input::W) || Input.trigger?(Input::w) # W ou w
      @sequence.push("W")
    elsif Input.trigger?(Input::T) || Input.trigger?(Input::t) # T ou t
      @sequence.push("T")
    elsif Input.trigger?(Input::O) || Input.trigger?(Input::o) # O ou o
      @sequence.push("O")
    end

    # Verifica se a sequência foi digitada corretamente
    if @sequence == target_sequence
      give_mewtwo_to_player
      @sequence.clear  # Limpa a sequência após liberar o Mewtwo
    end
  end

  def give_mewtwo_to_player
    # Libera o Mewtwo para o jogador
    mewtwo = Pokemon.new(:MEWTWO, 50)  # Verifique se o nome está correto
    $Trainer.party.push(mewtwo)
    pbMessage("\\PN ganhou um Mewtwo!")
  end
end
