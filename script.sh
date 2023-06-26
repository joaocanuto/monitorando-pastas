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
	local event_path="$1"
	local event_filename=$(basename "$event_path")
	local event_type="$2"

	# Sincronizando minha pasta original com minha pasta de backups.
	rsync -a --delete "$source_folder/" "$backup_folder/"
	
	#Verificando se a rsync encontrou algum erro.
	rsync_exit_code=$?
	if [ $rsync_exit_code -ne 0 ]; then
	    echo "Error: rsync failed with exit code $rsync_exit_code"
	fi
}



# Monitoramento da minha source_folder usando inotify
inotifywait -m -r -e create,delete,modify,move,close_write  "$source_folder"  |
while read -r directory event filename; do
    handle_event "$event_path" "$event"
    #Salvando as alterações no Log
    echo "$(date) - $event - $filename" >> "$log_file"
done
