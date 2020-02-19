#!/usr/bin/env bash

search_path="/share/glusterfs/ftp/aldebaran"
target_path="/old"
home_path="$HOME"

> dir_struct1
> dir_struct2

# Создаем структуру путей
find "$search_path" -type d -print0 \
 | while IFS= read -r -d $'\0' d; do
    target_full_path="${target_path}${d#$(echo "$search_path")}"
    mkdir -p "$target_full_path" 

    # И копируем файлы в найденой дирректории
    find "$d" -maxdepth 1 -type f -print0 -newermt '2000-01-01 00:00:01' ! -newermt '2017-12-31 23:59:59'\
     | while IFS= read -r -d $'\0' f; do
        cp "${f}" "$target_full_path"
    done
done
# Проверка
cd "$search_path"
find ./ > "${home_path}/dir_struct2"

cd "$target_path"
find ./ > "${home_path}/dir_struct1"

cd "$home_path"
diff dir_struct2 dir_struct1
# End of script

