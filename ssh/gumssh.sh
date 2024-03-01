#!/bin/bash

################
## OPERATIONS ##
################
main_menu(){
    choice=$(gum choose "" "" "")
    case $choice in
        "")
            while true; do
                user_type=$(gum choose "S")
                usertype_menu "$user_type"
            done
            ;;
        "Delete a user")
            delete_user_menu
            ;;
        "Quit")
            quit_script
            ;;
    esac
}

# Function to quit the script
quit_script() {
    # echo "Exiting script."
    gum spin --spinner dot --title "Exiting script...." -- sleep 1
    exit 0
}


###########
## MENUS ##
###########

##########
## MAIN ##
##########
main() {
    while true; do
        gum spin --spinner dot --title "Welcome to ssh manager..." -- sleep 1
        main_menu # "$choice"
    done
}

# Run main function
main
