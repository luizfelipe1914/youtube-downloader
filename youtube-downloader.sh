#!/bin/bash

clear

Menu(){
    
    echo "***********************************************************************"
    echo "*                                                                     *"
    echo "*                                                                     *"
    echo "*                                                                     *"
    echo "*                                                                     *"
    echo "*                       YOUTUBE DOWNLOADER                            *"
    echo "*                                                                     *"
    echo "*                                                                     *"
    echo "*                                                                     *"
    echo "*                                                                     *"
    echo "*                                                                     *"
    echo "***********************************************************************"

    echo "[ 1 ] Download de vídeo."
    echo "[ 2 ] Download de playlist."
    echo "[ 3 ] Extração de audio de vídeo."
    echo "[ 4 ] Extração de audio de uma playlist."
    echo "[ 5 ] Sair"
    echo -n "Qual a opção desejada ? "
    echo 
    read op

    case $op in
        1) BaixarVideo ;;
        2) BaixarPlaylist ;;
        3) ExtrairAudio ;;
        4) MenuPlaylistAudio ;;
        5) exit ;;
        *) echo "Opção inválida!"; echo ; Menu;;
    esac

}


BaixarVideo(){
    echo -n "Informe a url do vídeo: "
    read url
    youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "$url"
    Menu
}

BaixarPlaylist(){   
    MenuPlaylistVideo
}


MenuPlaylistVideo(){

    echo "[ 1 ] Download de toda playlist"
    echo "[ 2 ] Download de intervalo dentro da playlist"
    echo "[ 3 ] Download de items da playlist"
    echo "[ 4 ] Retornar ao menu principal"
    read escolha

    case $escolha in
        1) DownloadFull ;;
        2) DownloadInterval ;;
        3) DownloadItens ;;
        4) Menu ;;
        *) echo "Opção inválida!"; echo ; MenuPlaylistVideo;;
    esac
}

DownloadFull(){
    echo "URL da playlist: "
    echo 
    read url
    youtube-dl -o "%(title)s.%(ext)s" -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio0' --merge-output-format mp4 "$url"
    MenuPlaylistVideo
}

DownloadInterval(){
    echo "URL da playlist: "
    echo
    read url
    echo "índice de inicio: "
    echo
    read i
    echo "índice de término: "
    echo
    read f
    youtube-dl -o "%(title)s.%(ext)s" --playlist-start $i --playlist-end $f -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio0' --merge-output-format mp4 "$url"
    MenuPlaylistVideo
}

DownloadItems(){
    echo "URL da playlist: "
    echo
    read url
    echo "Quais itens? "
    echo
    read itens
    youtube-dl -o "%(title)s.%(ext)s" --playlist-items -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio0' --merge-output-format mp4 "$url"
    MenuPlaylistVideo
}

ExtrairAudio(){
    echo "URL: "
    echo
    read url
    youtube-dl --extract-audio --audio-format mp3 "$url" --prefer-ffmpeg
    Menu
}

ExtrairAudioPlaylist(){
    MenuPlaylistAudio
}

MenuPlaylistAudio(){
    echo "[ 1 ] Download de toda playlist"
    echo "[ 2 ] Download de intervalo dentro da playlist"
    echo "[ 3 ] Download de items da playlist"
    echo "[ 4 ] Retornar ao menu principal"
    read escolha

    case $escolha in
        1) DownloadFullAudio ;;
        2) DownloadIntervalAudio ;;
        3) DownloadItemsAudio ;;
        4) Menu ;;
        *) ;;
    esac
}

DownloadFullAudio(){
    echo "URl da playlist: "
    echo
    read url
    youtube-dl -o "%(title)s.%(ext)s" --extract-audio --audio-format mp3 "$url" --prefer-ffmpeg
    MenuPlaylistAudio
}

DownloadIntervalAudio(){
    echo "URl da playlist: "
    echo
    read url
    echo "índice de início: "
    echo
    read i
    echo "índice de fim: "
    echo
    read f
    youtube-dl -o "%(title)s.%(ext)s" --playlist-start $i --playlist-end $f --extract-audio --audio-format mp3 "$url" --prefer-ffmpeg
    MenuPlaylistAudio
}

DownloadItemsAudio(){
    echo "URL da playlist: "
    echo
    read url
    echo "Itens a baixar: "
    echo
    read itens
    youtube-dl -o "%(title)s.%(ext)s" --playlist-items $itens --extract-audio --audio-format mp3 "$url" --prefer-ffmpeg
    MenuPlaylistAudio
}

Menu