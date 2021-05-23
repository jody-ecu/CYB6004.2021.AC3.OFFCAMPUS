
#!/bin/bash
read -p "type the name of the folder you would like to create: " folderName
mkdir "./portfolio/$folderName"
mv ./foldermaker.sh "./portfolio/$folderName"
