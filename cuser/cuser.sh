#!/bin/bash

################
## OPERATIONS ##
################
# Function to create a superadmin user
create_superadmin() {
    username=$(gum input --placeholder "Enter username for superadmin: ")
    password=$(gum input --password --placeholder "Enter password for $username: ")
    gum spin --title "Setting password..." -- echo "$username:$password" | sudo chpasswd
    gum spin --title "Creating superadmin user..." -- sudo useradd -m $username
    gum spin --title "Adding to sudo group..." -- sudo usermod -aG sudo $username
    echo "$username ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$username
    gum spin --title "Setting permissions..." -- sudo chmod 440 /etc/sudoers.d/$username
    echo "Superadmin user $username created successfully."
}
# Function to create an adminuser
create_adminuser() {
    username=$(gum input --placeholder "Enter username for adminuser: ")
    password=$(gum input --password --placeholder "Enter password for $username: ")
    gum spin --title "Setting password..." -- echo "$username:$password" | sudo chpasswd
    gum spin --title "Creating admin user..." -- sudo useradd -m $username
    gum spin --title "Adding to sudo group..." -- sudo usermod -aG sudo $username
    echo "Adminuser $username created successfully with password authentication."
}
# Function to create a regular user
create_regular_user() {
    username=$(gum input --placeholder "Enter username for regular user: ")
    password=$(gum input --password --placeholder "Enter password for $username: ")
    gum spin --title "Creating regular user..." -- sudo useradd -m $username
    echo "Regular user $username created successfully."
}
delete_user() {
    username=$(gum input --placeholder "Enter username to delete: ")
    gum spin --title "Deleting user..." -- sudo userdel -r $username
    echo "User $username deleted successfully."
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
main_menu (){
choice=$(gum choose "Create a user" "Delete a user" "Quit")
# case $"$@" in
case $choice in
    "Create a user")
        while true; do
            user_type=$(gum choose "Superadmin" "Adminuser" "Regular user" "Go back" "Quit")
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
usertype_menu() {
    # case $user_type in
    case "$@" in
        "Superadmin")
            create_superadmin
            ;;
        "Adminuser")
            create_adminuser
            ;;
        "Regular user")
            create_regular_user
            ;;
        "Go back")
            main_menu
            ;;
        "Quit")
            quit_script
            ;;
    esac
}
# Function to delete a user
delete_user_menu() {
    choice=$(gum choose "Yup" "Go back" "Quit")
    choice_menu=$choice
    case "$choice" in
        "Yup")
            delete_user "$choice_menu"
            ;;
        "Go back")
            main_menu
            ;;
        "Quit")
            quit_script
            ;;
    esac
}
# Function to go back to the first menu
go_back() {
    # echo "Returning to the main menu."
    gum spin --spinner dot --title "Returning to the main menu..." -- sleep 1
    usertype_menu
}


##########
## MAIN ##
##########
main() {
    while true; do
        gum spin --spinner dot --title "Welcome to user management script..." -- sleep 1
        main_menu # "$choice"
    done
}

# Run main function
main
