# Doc - Monitorando Pastas

# Documentação do Script

## Introdução

Esta documentação descreve o funcionamento e a estrutura de um script em Bash desenvolvido para monitorar uma pasta específica e realizar backups automáticos de seus arquivos. O script utiliza o inotify para detectar eventos como criação, exclusão, modificação, movimentação de arquivos na pasta monitorada. Sempre que um evento ocorre, os arquivos são sincronizados com uma pasta de backup usando o comando rsync.

## Execução do programa

Para executar o programa corretamente, é necessário seguir os seguintes passos:

1. Defina as pastas de ação do script nos parâmetros `source_folder`, `backup_folder` e `log_file`. Certifique-se de inserir os caminhos corretos para as respectivas pastas em seu computador.
2. Instale as dependências necessárias para a execução do script. 
    
    ```bash
    sudo apt-get update
    sudo apt-get install inotify-tools
    ```
    
3. Salve o script em um arquivo com extensão ".sh", por exemplo, `monitor.sh`.
    
    > nesse caso, clonando o projeto, basta executar o `script.sh`.
    > 
4. Abra o terminal e navegue até o diretório onde o script foi salvo.
5. Execute o script:
    
    ```bash
    # primeiro é necessário dar permissões ao script
    	chmod +x script.sh
    # E então poderá rodar o script:
    	./script.sh
    ```
    

## Bibliotecas Utilizadas

O script em Bash utiliza as seguintes bibliotecas:

- inotifywait: Biblioteca que permite monitorar eventos em um sistema de arquivos Linux. Ela é usada para detectar eventos de criação, exclusão, modificação, movimentação e fechamento de escrita de arquivos na pasta monitorada.
- rsync: Utilizado para sincronizar arquivos e diretórios entre diferentes localizações. Neste script, o rsync é usado para sincronizar os arquivos da pasta original com a pasta de backup.

Certifique-se de que essas bibliotecas estejam instaladas em seu sistema antes de executar o script.

## Funções Utilizadas

O script utiliza a seguinte função:

### handle_event

A função `handle_event` é responsável por lidar com os eventos detectados pelo inotify. Ela recebe dois parâmetros: `event_path` e `event_type`. O `event_path` representa o caminho completo para o arquivo que gerou o evento, enquanto `event_type` indica o tipo de evento ocorrido.

Dentro da função, os seguintes passos são executados:

1. Sincronização dos arquivos da pasta original com a pasta de backup usando o comando `rsync`. Isso garante que os arquivos de backup estejam sempre atualizados.
2. Verificação se o comando `rsync` encontrou algum erro. Caso haja algum erro, uma mensagem de erro será exibida no terminal.

## Estrutura do Código

O script possui a seguinte estrutura:

1. Definição das pastas de ação do script, como `source_folder`, `backup_folder` e `log_file`.
2. Validação da existência do arquivo de log. Caso o arquivo não exista, ele será criado.
3. Remoção da pasta de backup existente e criação de uma nova pasta de backup. Os arquivos da pasta original são copiados para a pasta de backup.
4. Definição da função `handle_event` para lidar com os eventos detectados pelo inotify.
5. Monitoramento da pasta `source_folder` usando o comando `inotifywait`. O

script aguarda por eventos de criação, exclusão, modificação, movimentação e fechamento de escrita de arquivos nessa pasta. Sempre que um evento ocorre, a função `handle_event` é chamada para sincronizar os arquivos e registrar as alterações no arquivo de log.

## Conclusão e Considerações Finais

O script desenvolvido é uma solução simples e eficiente para monitorar uma pasta específica e realizar backups automáticos de seus arquivos. Ele utiliza o inotify para detectar eventos e o rsync para sincronizar os arquivos com uma pasta de backup. O script pode ser personalizado de acordo com as necessidades individuais, como a definição de pastas e a adição de outras ações dentro da função `handle_event`.

## Referências

Aqui estão algumas referências usadas relacionados aos temas: Bash, iwatch, rsync e exemplos de scripts Bash com iwatch:

- [GNU Bash Documentation](https://www.gnu.org/software/bash/manual/)
- [inotifywait - Linux man page](https://manpages.debian.org/buster/inotify-tools/inotifywait.1.en.html)
- [rsync - Linux man page](https://manpages.debian.org/buster/rsync/rsync.1.en.html)
- [iwatch GitHub Repository](https://github.com/iij/iwatch)
- [iwatch - Monitorando diretórios e executando comandos](https://www.vivaolinux.com.br/artigo/iwatch-Monitorando-diretorios-e-executando-comandos)
- [How to Use rsync for Local and Remote File Copy/Backup](https://www.tecmint.com/rsync-local-remote-file-synchronization-commands/)
- [Como Usar o Comando Rsync Linux (Sincronização Remota)](https://www.hostinger.com.br/tutoriais/comando-rsync-linux)