# README
# Online Auction System
System to buy and sell things

# Prerequisites
* Ruby version
  ruby 3.3.0
* Rails version
  7.1.3

# Basic use libraries installation
* sudo apt update
* sudo apt install unace unrar zip unzip p7zip-full p7zip-rar sharutils gnupg2 rar uudeview mpack arj cabextract file-roller

# Actual Development Setup
* sudo apt-get install curl git gitk
* curl -L get.rvm.io | bash -s stable

# Other dependencies
Ruby and rails is required to run this project. For installation you can follow the following link:
  https://gist.github.com/ziaulrehman40/0e3afe55d5d1f93e5bfb02f5a117567c#rvm

# For installation of postgress installation
* sudo apt install postgresql pgadmin4

# Check out the repository
git clone https://github.com/uroojiqbal/online_auction_system

# Install dependencies
To install the dependencies run:
* bundle install or bundle

# Database creation and setting up
Run the following commands to create and setting up the database.
* bundle exec rake db:setup

# API keys and credentials
To Run the app credential file must contains credentials for following:
* cloudinary needs, cloud_name, api_key , api_secret
* For smtp configuration user_name, password are needed
* For stripe public_key, secret_key are needed

To edit the credential file in vscode run following command:
* EDITOR="code --wait" rails credentials:edit

To edit the credential file in vim run following command:
* EDITOR="vim" rails credentials:edit

To edit the credential file in atom run following command:
* EDITOR="atom" rails credentials:edit

# Start the Rails server
You can start the rails server using the command given below.
* bundle exec rails s
And now you can visit the site with the URL http://localhost:3000
