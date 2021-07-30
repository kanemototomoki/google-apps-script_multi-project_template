#!/bin/zsh

function showError() {
  line='================================================='
  esc=$(printf '\033')

  echo ''
  printf "${esc}[32m%s${esc}[m\n" $line
  echo ''
  echo 'ERROR:' $1
  echo ''
  printf "${esc}[32m%s${esc}[m\n" $line
  echo ''
}

# 第1引数が指定されていないとき
if [ -z $1 ]; then
  showError 'deployするディレクトリ名を入力してください。'
  exit 1
fi

# src配下に存在しないディレクトリ名のとき
if [ ! -d $(pwd)/src/$1 ]; then

  showError '`src` 配下に存在するディレクトリ名を入力してください。'

  exit 1
fi

# 第2引数が指定されていないとき
if [ -z $2 ]; then
  showError 'deployIDを入力してください。以下参照！\nhttps://developers.google.com/apps-script/concepts/deployments#find_a_deployment_id'
  exit 1
fi

# clasp list を実行して対象のプロジェクト名と一致するスクリプトIDを`.clasp.json`に書き込む
url=`npx clasp list |
grep $1 | grep -Eo '(/d/)[0-9a-zA-Z?=#+_&:/.%]+(/edit)$' |
sed -E 's/(\/d\/|\/edit)//g'`

echo "{ \"scriptId\": \"$url\" }" > .clasp.json

npm run build --my_target_dir=$1 && cd dist/$1 &&
npx clasp push &&
npx clasp deploy -i $2
