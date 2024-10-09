#!/usr/bin/env bash
#*-----------------------------------------------------------------------------
__require__ \
    "helpers/shell/output.sh" \
    "helpers/fs/backups.sh" \
;
#*-----------------------------------------------------------------------------

_VIMRC_TEMPLATE="$(__script_base_dir__)/config/template.vimrc";

main() {
    clean;
    setup;
}


#*-----------------------------------------------------------------------------
# * CLEANUP

clean() {
    show_msg "Backing up existing vim configs ...";
    indent 2;

        if [[ -d $HOME/.vim ]]; then backup "$HOME/.vim"; fi
        if [[ -f $HOME/.vimrc ]]; then backup "$HOME/.vimrc"; fi

    indent -2;
}

#*-----------------------------------------------------------------------------
# * SETUP

setup() {
    show_msg "Creating folder structure ...";

    mkdir -p $HOME/.vim $HOME/.vim/autoload $HOME/.vim/backup $HOME/.vim/colors $HOME/.vim/plugged;

    show_msg "Copying .vimrc ...";
    cp "$_VIMRC_TEMPLATE" "$HOME/.vimrc";

    show_msg "Installing vim-plug ...";
    curl -fsLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;

    show_msg "Installing specified plugins from .vimrc ...";
    vim +'PlugInstall --sync' +qa --not-a-term > /dev/null;
}


#*-----------------------------------------------------------------------------
main $@