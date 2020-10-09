#备份（本地版）
#备份路径为/storage/emulated/0/WeChat_backup/

###################配置区###################



need_pictures="1" #备份图片开关，1为开启，0为关闭
need_voice="1" #备份语音开关，1为开启，0为关闭
need_video="1" #备份视频开关，1为开启，0为关闭
need_files="1" #备份下载文件开关，1为开启，0为关闭


delete_day="0" #自动删除x天前备份数据的开关，0为关闭



############################################



#by:酷安@搓澡君



############################################

rm -rf /storage/emulated/0/WeChat_tmp/
mkdir /storage/emulated/0/WeChat_tmp/

if [ ! -d "/storage/emulated/0/WeChat_backup" ]; then
        mkdir /storage/emulated/0/WeChat_backup
fi


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

echo "开始备份……"
ps -ef | grep com.tencent.mm | grep -v grep |awk '{print $2}' | xargs kill -9 >> /dev/null 2>&1

rm -rf /storage/emulated/0/WeChat_tmp/backup
mkdir /storage/emulated/0/WeChat_tmp/backup







echo "备份聊天记录中…"
check_dir_name="EnMicroMsg"
dir_all=$(ls -l /data/data/com.tencent.mm/MicroMsg/ |awk '/^d/ {print $NF}')
for dir_i in $dir_all
do
if (( ${#dir_i} >25 ));then
 dir_cut=$(ls "/data/data/com.tencent.mm/MicroMsg/${dir_i}")
for dir_name in $dir_cut
do
 if [[ $dir_name == *$check_dir_name* ]];then
 if [ ! -d /storage/emulated/0/WeChat_tmp/backup/$dir_i  ];then
  mkdir /storage/emulated/0/WeChat_tmp/backup/$dir_i
 fi
 cp -r /data/data/com.tencent.mm/MicroMsg/${dir_i}/${dir_name} /storage/emulated/0/WeChat_tmp/backup/$dir_i
 fi
 done
 
 if (( need_voice == 1 ));then
  if [ -e /data/data/com.tencent.mm/MicroMsg/${dir_i}/account.bin  ];then
 cp -rf /data/data/com.tencent.mm/MicroMsg/${dir_i}/account.bin /storage/emulated/0/WeChat_tmp/backup/$dir_i
 fi
 elif (( need_video == 1 ));then
   if [ -e /data/data/com.tencent.mm/MicroMsg/${dir_i}/account.bin  ];then
 cp -rf /data/data/com.tencent.mm/MicroMsg/${dir_i}/account.bin /storage/emulated/0/WeChat_tmp/backup/$dir_i
 fi
 fi
 
 if (( need_pictures == 1 ));then
 if [ -d /data/data/com.tencent.mm/MicroMsg/${dir_i}/image2  ];then
 echo "备份图片消息中…"
 cp -rf /data/data/com.tencent.mm/MicroMsg/${dir_i}/image2 /storage/emulated/0/WeChat_tmp/backup/$dir_i
 echo "备份图片消息完成"
 fi
 fi
 
 
fi
done
echo "备份聊天记录完成"


if (( need_voice == 1 ));then
echo "备份语音消息中…"
 mkdir /storage/emulated/0/WeChat_tmp/backup/voice
voice_check_dir_name="voice2"
voice_dir_all=$(ls -l /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/ |awk '/^d/ {print $NF}')
for voice_dir_i in $voice_dir_all
do

if (( ${#voice_dir_i} >25 ));then
 voice_dir_cut=$(ls "/storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${voice_dir_i}")
 
for voice_dir_name in $voice_dir_cut
do
 if [[ $voice_dir_name == *$voice_check_dir_name* ]];then
  if [ ! -d /storage/emulated/0/WeChat_tmp/backup/voice/$voice_dir_i  ];then
  mkdir /storage/emulated/0/WeChat_tmp/backup/voice/$voice_dir_i
 fi
cp -r /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${voice_dir_i}/${voice_dir_name} /storage/emulated/0/WeChat_tmp/backup/voice/$voice_dir_i
fi
done

fi

done
echo "备份语音消息完成"
fi



if (( need_video == 1 ));then
echo "备份视频文件中…"
 mkdir /storage/emulated/0/WeChat_tmp/backup/video
video_check_dir_name="video"
video_dir_all=$(ls -l /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/ |awk '/^d/ {print $NF}')
for video_dir_i in $video_dir_all
do

if (( ${#video_dir_i} >25 ));then
 video_dir_cut=$(ls "/storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${video_dir_i}")
 
for video_dir_name in $video_dir_cut
do
 if [[ $video_dir_name == *$video_check_dir_name* ]];then
  if [ ! -d /storage/emulated/0/WeChat_tmp/backup/video/$video_dir_i  ];then
  mkdir /storage/emulated/0/WeChat_tmp/backup/video/$video_dir_i
 fi
cp -r /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${video_dir_i}/${video_dir_name} /storage/emulated/0/WeChat_tmp/backup/video/$video_dir_i
fi
done

fi

done
echo "备份视频文件完成"
fi



if (( need_files == 1 ));then
echo "备份下载的文件中…"
 cp -r /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/Download /storage/emulated/0/WeChat_tmp/backup >> /dev/null 2>&1
 echo "备份下载的文件完成"
fi




time2=$(date "+%Y%m%d")
cd /storage/emulated/0/WeChat_tmp/ && tar -cf ${time2}.tar ./backup/*
mv /storage/emulated/0/WeChat_tmp/${time2}.tar /storage/emulated/0/WeChat_backup/
echo "微信数据打包完成"




if (( $delete_day > 0 ));then
echo "开始删除${delete_day}天前的备份文件"
check_file_name='.tar'

file_date=$(ls "/storage/emulated/0/WeChat_backup/")
 
for file_name in $file_date
do
if [[ $file_name == *$check_file_name* ]];then
file_name_date=${file_name: 0 : 8 }
file_date=$(($time2-$file_name_date))
if (( $file_date > $delete_day ));then
rm -f /storage/emulated/0/WeChat_backup/${file_name}
fi
fi
done
fi



rm -rf /storage/emulated/0/WeChat_tmp/