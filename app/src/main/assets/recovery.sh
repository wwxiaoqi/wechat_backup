#恢复（本地版）
#路径/storage/emulated/0/WeChat_backup/

###################配置区###################



recovery_date="20200913" #需要恢复数据的日期，格式"年月日"



############################################



#by:酷安@搓澡君



############################################

rm -rf /storage/emulated/0/WeChat_tmp/
mkdir /storage/emulated/0/WeChat_tmp/

cut_string(){
all_string=$1
all_string=`echo $all_string  | sed s/[[:space:]]//g  `
first_string=$2
first_cut=${all_string#*$first_string}
second_string=$3
second_string_position=`awk -v a="$first_cut" -v b="$second_string" 'BEGIN{print index(a,b)}'`
second_string_position=$(($second_string_position-1))
final_string=${first_cut: 0 : second_string_position }
echo $final_string
}


echo "开始恢复……"
ps -ef | grep com.tencent.mm | grep -v grep |awk '{print $2}' | xargs kill -9 >> /dev/null 2>&1
cp /storage/emulated/0/WeChat_backup/${recovery_date}.tar /storage/emulated/0/WeChat_tmp/


echo "开始恢复${recovery_date}的微信数据"
echo "恢复聊天记录与图片消息（如果有）中…"
check_dir_name="EnMicroMsg"
check_dir_name2="EnMicroMsg2"
cd /storage/emulated/0/WeChat_tmp/ && tar -xf ${recovery_date}.tar >> /dev/null 2>&1
recovery_dir_all=$(ls -l /storage/emulated/0/WeChat_tmp/backup |awk '/^d/ {print $NF}')
for dir_i in $recovery_dir_all
do

if (( ${#dir_i} >25 ));then
cp -r -f /storage/emulated/0/WeChat_tmp/backup/${dir_i} /data/data/com.tencent.mm/MicroMsg/

dir_cut=$(ls "/data/data/com.tencent.mm/MicroMsg/${dir_i}")
for dir_name in $dir_cut
do
 if [[ $dir_name == *$check_dir_name* ]];then
 chmod 0664 /data/data/com.tencent.mm/MicroMsg/${dir_i}/$dir_name
 fi
done

for dir_name2 in $dir_cut
do
 if [[ $dir_name2 == *$check_dir_name2* ]];then
 rm -f /data/data/com.tencent.mm/MicroMsg/${dir_i}/$dir_name2
 fi
done
fi

done


for dir_i in $recovery_dir_all
do
if (( ${#dir_i} >25 ));then
 dir_cut=$(ls "/data/data/com.tencent.mm/MicroMsg/${dir_i}")
for dir_name in $dir_cut
do

 if [ -d /data/data/com.tencent.mm/MicroMsg/${dir_i}/image2  ];then
 chmod -R 0777 /data/data/com.tencent.mm/MicroMsg/${dir_i}/image2 /storage/emulated/0/WeChat_tmp/backup/$dir_i
 fi
 
done
fi
done

echo "恢复聊天记录与图片消息（如果有）完成"

if [ ! -d "/storage/emulated/0/Android/data/com.tencent.mm" ]; then
        mkdir /storage/emulated/0/Android/data/com.tencent.mm
fi

if [ ! -d "/storage/emulated/0/Android/data/com.tencent.mm/MicroMsg" ]; then
        mkdir /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg
fi


all_backup_dir=$(ls "/storage/emulated/0/WeChat_tmp/backup/")

check_voice_name="voice"
check_video_name="video"
check_files_name="Download"
if [[ $all_backup_dir == *$check_voice_name* ]];then
echo "恢复语音消息中…"
cp -rf /storage/emulated/0/WeChat_tmp/backup/voice/ /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/
echo "恢复语音消息完成"
fi

if [[ $all_backup_dir == *$check_video_name* ]];then
echo "恢复视频文件中…"
cp -rf /storage/emulated/0/WeChat_tmp/backup/video/ /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/
echo "恢复视频文件完成"
fi

if [[ $all_backup_dir == *$check_files_name* ]];then
echo "恢复下载的文件中…"
cp -rf /storage/emulated/0/WeChat_tmp/backup/Download /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/
echo "下载的文件恢复完成"
fi


echo "恢复完成！！！"
rm -rf /storage/emulated/0/WeChat_tmp/
