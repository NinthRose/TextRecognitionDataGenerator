

cd $(dirname $0)
home=$(pwd)

target=/media/zhangyaqi/software/ubuntu/code/raptor/raptor/poi/ocr/model/train/data/ocr/out

cd $target && rm *

cd $home

source ../venv3/bin/activate

rm -rf out
while [ -d out ];do
    sleep 1;
    echo "removing the latest output files."
done

python run.py -l cn -c 1000 -w 5 -na 2
#######################################
num_old=$(ls out | wc)
sleep 1
num_new=$(ls out | wc)

while [ "$num_new" != "$num_old" ];do
    num_old="$num_new"
    sleep 5
    num_new=$(ls out | wc)
done

echo "create images done."

#######################################

cd out

while read line;do
    name=$(echo "$line" | awk -F "\." '{print $1}')
    content=$(echo "$line" | awk '{print $2" "$3" "$4" "$5" "$6}')
    echo "$content" > $name.txt
done < labels.txt

mv * $target

