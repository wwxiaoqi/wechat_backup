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
am force-stop com.tencent.mm

rm -rf /storage/emulated/0/WeChat_tmp/backup
mkdir /storage/emulated/0/WeChat_tmp/backup

echo "备份聊天记录中…"
dir_all=$(ls "/data/data/com.tencent.mm/MicroMsg/")
for dir_i in $dir_all
do

if (( ${#dir_i} > 30 )) && (( ${#dir_i} < 34 ));then
 dir_cut=$(ls "/data/data/com.tencent.mm/MicroMsg/${dir_i}")
for dir_name in $dir_cut
do
 if [[ $dir_name == *"EnMicroMsg2"* ]];then
 rm -f /data/data/com.tencent.mm/MicroMsg/${dir_i}/${dir_name}
 elif [[ $dir_name == *"EnMicroMsg"* ]];then
 if [ ! -d /storage/emulated/0/WeChat_tmp/backup/$dir_i  ];then
  mkdir /storage/emulated/0/WeChat_tmp/backup/$dir_i
 fi
 cp -rf /data/data/com.tencent.mm/MicroMsg/${dir_i}/${dir_name} /storage/emulated/0/WeChat_tmp/backup/$dir_i
 fi


if (( need_pictures == 1 ));then
 if [[ $dir_name == *"image2"* ]];then
 echo "备份data/data/微信图片中…"
 cp -rLf /data/data/com.tencent.mm/MicroMsg/${dir_i}/${dir_name} /storage/emulated/0/WeChat_tmp/backup/
 echo "备份data/data/微信图片完成！"
 fi
fi
done

fi
done




storage_dir_all=$(ls "/storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/")
for storage_dir_i in $storage_dir_all
do

if (( ${#storage_dir_i} > 30 )) && (( ${#storage_dir_i} < 34 ));then
 storage_dir_cut=$(ls "/storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}")
for storage_dir_name in $storage_dir_cut
do
if (( need_pictures == 1 ));then
 if [[ $storage_dir_name == *"image2"* ]];then
 echo "备份/Android/data/微信图片中…"
 cp -rLf /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/${storage_dir_name} /storage/emulated/0/WeChat_tmp/backup/
 echo "备份/Android/data/微信图片完成！"
 fi
fi

if (( need_voice == 1 ));then
 if [[ $storage_dir_name == *"voice2"* ]];then
 echo "备份/Android/data/微信语音中…"
 cp -rLf /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/${storage_dir_name} /storage/emulated/0/WeChat_tmp/backup/
 echo "备份/Android/data/微信语音完成！"
 fi
fi

if (( need_video == 1 ));then
 if [[ $storage_dir_name == *"video"* ]];then
 echo "备份/Android/data/微信视频中…"
 cp -rLf /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/${storage_dir_name} /storage/emulated/0/WeChat_tmp/backup/
 echo "备份/Android/data/微信视频完成！"
 fi
fi
done

fi
done



tencent="tencent"
 if [ ! -d /storage/emulated/0/tencent  ];then
 tencent="Tencent"
 fi
 
if [ -d /storage/emulated/0/${tencent}/MicroMsg/ ];then
tencent_dir_all=$(ls "/storage/emulated/0/${tencent}/MicroMsg/")
for tencent_dir_i in $tencent_dir_all
do

if (( ${#tencent_dir_i} > 30 )) && (( ${#tencent_dir_i} < 34 ));then
 tencent_dir_cut=$(ls "/storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}")
for tencent_dir_name in $tencent_dir_cut
do
if (( need_pictures == 1 ));then
 if [[ $tencent_dir_name == *"image2"* ]];then
 echo "备份/${tencent}/微信图片中…"
 cp -rLf /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/${tencent_dir_name} /storage/emulated/0/WeChat_tmp/backup/
 echo "备份/${tencent}/微信图片完成！"
 fi
fi

if (( need_voice == 1 ));then
 if [[ $tencent_dir_name == *"voice2"* ]];then
 echo "备份/${tencent}/微信语音中…"
 cp -rLf /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/${tencent_dir_name} /storage/emulated/0/WeChat_tmp/backup/
 echo "备份/${tencent}/微信语音完成！"
 fi
fi

if (( need_video == 1 ));then
 if [[ $tencent_dir_name == *"video"* ]];then
 echo "备份/${tencent}/微信视频中…"
 cp -rLf /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/${tencent_dir_name} /storage/emulated/0/WeChat_tmp/backup/
 echo "备份/${tencent}/微信视频完成！"
 fi
fi
done

fi
done
fi



if (( need_files == 1 ));then
echo "备份下载的文件中…"
 if [ -d /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/Download  ];then
 cp -rLf /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/Download /storage/emulated/0/WeChat_tmp/backup
 fi
 if [ -d /storage/emulated/0/tencent/MicroMsg/Download  ];then
 cp -rLf /storage/emulated/0/tencent/MicroMsg/Download /storage/emulated/0/WeChat_tmp/backup
 fi
echo "备份下载的文件完成"
fi

if [ -e /data/data/com.tencent.mm/files/KeyInfo.bin  ];then
 cp -f /data/data/com.tencent.mm/files/KeyInfo.bin /storage/emulated/0/WeChat_tmp/backup
echo "获取跨设备恢复关键文件成功！"
else
echo "获取跨设备恢复关键文件失败！可能导致数据包无法跨设备恢复！"
fi

if [ -d /storage/emulated/0/WeChat_tmp/backup/video ];then
video_dir=$(ls "/storage/emulated/0/WeChat_tmp/backup/video")
for video_dir_i in $video_dir
do
 if [[ $video_dir_i == *".tmp"* ]];then
 rm -f /storage/emulated/0/WeChat_tmp/backup/video/${video_dir_i}
 fi
done
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
if [[ $file_date -ge $delete_day ]];then
rm -f /storage/emulated/0/WeChat_backup/${file_name}
fi
fi
done
echo "删除${delete_day}天前的备份文件完成！"
fi

rm -rf /storage/emulated/0/WeChat_tmp/
echo "备份全部完成啦！！！"