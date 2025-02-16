EN :

# Portfolio flutter app for devs

The goal of this app is to give a dynamic portfolio app for devs. You just have to update the .env file and put your PAT and your github username in it. I added the most common used languages but if there are missing just add it in the **sortedRepos** map in the **github_service.dart** (format : '<language_name>' : []) file. You'll also have to add topics on TS, JS and dart repos with the name of the framwork used beacause github don't detect frameworks as languages by default. To do it go to your repo, click the settings button on the right of "About" and fill the Topics field. I'll try to automate all this later but for now it works as this. Also don't hesitate to make UI changes, I'm really bad in design haha.

FR :

# Application de portfolio en flutter pour les développeurs

L'objectif de cette application était de fournir un portfolio dynamique pour les développeurs. Tout ce que vous avez à faire est de mettre à jour le fichier .env et y ajouter votre PAT et votre nom d'utilisateur github dedans. J'ai ajouté la plupart des langages les plus utilisés mais si il en manque n'hésitez pas à les ajouter dans la map **sortedRepos** dans le fichier **github_service.dart** (format : '<nom_du_langage>' : []). Pour cela rendez vous sur votre repo, cliquez sur le bouton paramètres à droite de "About" et remplissez le champ Topics. J'essaierai d'automatiser tout ça plus tard mais pour le moment ça fonctionne correctement comme ça. N'hésitez surtout pas à modifier l'UI, je suis très mauvais en design haha.
