Send me feedback on Discord: Naim#8408

For my intentions AI_Trickstar Burn is finished (until i learn how to use battle commands properly).
I'll be moving to AI_Trickstars now.

Instructions in Portuguese and English:


# COMO UTILIZAR

Requerimentos:

Ygopro Percy 1.033D(a)

Notepadd++ ou similar


1-Baixe os arquivos LUA e YDK correspondentes à AI desejada

2-Adicione o arquivo YDK na pasta ``deck``

3-Adicione o arquivo LUA na pasta ``ai\decks``

4-Abra o arquivo ``ai.lua`` na pasta ``ai``

5-Adicione a seguinte linha entres as linhas "require":

	require("ai.decks.NOMEDODECK")

Exemplo:

	require("ai.decks.Eidolon")
	
	require("ai.decks.Trickstars") <---- este adionará o deck trickstar
	
	requireoptional("ai.decks.ZodiacBeast")
	
	requireoptional("ai.decks.Fluffal")
	
Salve as alterações
	
	
6-Selecione o deck desejado quando for duelar com a AI







# HOW TO ADD THESE AI DECKS TO YOUR CLIENT


Requirements:

Ygopro Percy 1.033D(a)

Notepadd++ or similar



1-Download both LUA e YDK files for the AI you want to play against

2-Add the YDK file to the ``deck`` folder

3-Add the LUA file to the ``ai\decks`` folder

4-Open the ``ai.lua`` file  in your ``ai`` folder

5-Add this line, among the "require" lines:

	require("ai.decks.DECKNAME")

e.g.

	require("ai.decks.Eidolon")
	
	require("ai.decks.Trickstars") <---- This line will add Trickstars AI
	
	requireoptional("ai.decks.Fluffal")
	
Save the changes
	
	
6-While in the AI mode, choose the new deck

