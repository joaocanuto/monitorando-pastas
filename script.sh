#!/bin/bash

# Definindo pastas de ação do script.
# Aqui para o script funcionar sem erros no seu computador é preciso setar os caminhos 
# corretamento:
source_folder=""
backup_folder=""
log_file=""


# Validando se minha log_file.txt existe, se não existir quero cria-lá
if [ ! -f "$log_file" ]; then
    touch "$log_file"
fi

# Recriando minha pasta de backup
rm -rf "$backup_folder"
cp -r "$source_folder" "$backup_folder"

#Função Criada para lidar com eventos
handle_event() {
	# Sincronizando minha pasta original com minha pasta de backups.
	rsync -a --delete "$source_folder/" "$backup_folder/"
	
	#Verificando se a rsync encontrou algum erro.
	rsync_exit_code=$?
	if [ $rsync_exit_code -ne 0 ]; then
	  echo "Error: rsync failed with exit code $rsync_exit_code"
	fi
}



# Monitoramento da minha source_folder usando inotify
# -m monitoramento continuo
# -r monitorament recursivo
# -e eventos a serem monitorados
# Eventos : 
# create -> evento acionado quando um arquivo ou pasta é criado
# delete -> evento acionado quando um arquivo ou pasta é deletado
# modify -> evento acionado quando um arquivo ou pasta  é modificado. 
# : Qualquer alteração feita em um arquivo existente, como alterar seu conteúdo ou metadados, acionará o evento modify.
# move -> evento acionado quando um arquivo ou pasta é movido.
# : Se um arquivo for movido de um local para outro ou renomeado, o evento move será detectado
# close_write -> evento acionado quando um arquivo é fechado após ter sido aberto para gravação.
# : Ele ocorre quando um processo conclui a escrita em um arquivo na pasta monitorada e fecha o arquivo.
inotifywait -m -r -e create,delete,modify,move,close_write  "$source_folder"  |
while read -r directory event filename; do 
    #itera sobre cada linha de saída do comnando inotifywait 
    # read -r -> É um comando do shell que lê uma linha de entrada e atribui os valores às variáveis especificadas.
    # directory -> É uma variável que receberá o valor do diretório relacionado ao evento.
    # event -> É uma variável que receberá o tipo de evento ocorrido.
    # filename -> É uma variável que receberá o nome do arquivo relacionado ao evento.

    handle_event 

    #Salvando as alterações no Log
    echo "$(date) - $event - $filename" >> "$log_file"
done
