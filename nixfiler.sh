rm -rf /etc/nixos
mkdir /etc/nixos

for folder in $(find .  -mindepth 1 -type d | grep -v "git")
do
    echo "creating dir ${folder/"."/"/etc/nixos"}"
    mkdir -p ${folder/"."/"/etc/nixos"}
done

for file in $(find . -type f | grep -v "git" | grep -v "nixfiler") 
do
    echo "linking ${file/"."/"/etc/nixos"}"
    ln -f $file "${file/"."/"/etc/nixos"}"; 
done