#!/bin/zsh

select_list=`npx clasp list | sed -E 's/(\[2K|\[1G)//g' | sed -E 's/[[:cntrl:]]//g'`

touch tmp.txt
echo $select_list > tmp.txt

select_arr=()
cat tmp.txt | while read line; do
  select_arr+=($line)
done

rm tmp.txt

PS3="cloneするプロジェクトの番号を入力してください => "
select project in ${select_arr[@]}; do

  if [ -z $project ]; then
    echo ""
    echo "ERROR: 1 ~ ${#select_arr[@]} の間の数字を入力してください。"
    echo ""
    exit 1
  fi

  url=`echo $project | grep -Eo 'http(s?)://[0-9a-zA-Z?=#+_&:/.%\-]+'`
  project_name=`echo $project | grep -Eo '^[0-9a-zA-Z?=#+_&:/.%\-]+'`

  # すでにクローン済みの場合
  if [ -e ./src/$project_name ]; then
    echo ""
    echo "ERROR: すでに同名のプロジェクトが存在します。"
    echo ""
    exit 1
  fi

  rm .clasp.json
  mkdir ./src/$project_name
  clasp clone $url --rootDir ./src/$project_name
  break;
done
