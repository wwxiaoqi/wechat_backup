#恢复（本地版）
#路径/storage/emulated/0/WeChat_backup/

###################配置区###################



recovery_date="20201010" #需要恢复数据的日期，格式"年月日"



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
am force-stop com.tencent.mm
cp /storage/emulated/0/WeChat_backup/${recovery_date}.tar /storage/emulated/0/WeChat_tmp/
cd /storage/emulated/0/WeChat_tmp/ && tar -xf ${recovery_date}.tar >> /dev/null 2>&1

 tencent="tencent"
 if [ ! -d /storage/emulated/0/tencent  ];then
 tencent="Tencent"
 fi
if [ ! -d "/storage/emulated/0/Android/data/com.tencent.mm/MicroMsg" ]; then
        mkdir /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg
fi
if [ ! -d "/storage/emulated/0/${tencent}/MicroMsg" ]; then
        mkdir /storage/emulated/0/${tencent}/MicroMsg
fi
recovery_dir_all=$(ls "/storage/emulated/0/WeChat_tmp/backup/")
data_dir_all=$(ls "/data/data/com.tencent.mm/MicroMsg/")
for recovery_dir_i in $recovery_dir_all
do
if (( ${#recovery_dir_i} > 30 )) && (( ${#recovery_dir_i} < 34 ));then
echo "恢复文字聊天记录中…"
cp -rf /storage/emulated/0/WeChat_tmp/backup/${recovery_dir_i}/* /data/data/com.tencent.mm/MicroMsg/${recovery_dir_i}/
echo "恢复文字聊天记录完成！"
fi
done

for data_dir_i in $data_dir_all
do
if (( ${#data_dir_i} > 30 )) && (( ${#data_dir_i} < 34 ));then
data_dir_cut=$(ls "/data/data/com.tencent.mm/MicroMsg/${data_dir_i}")
 for data_dir_cut_i in $data_dir_cut
 do
 if [[ $data_dir_cut_i == *"EnMicroMsg2"* ]];then
 rm -f /data/data/com.tencent.mm/MicroMsg/${data_dir_i}/${data_dir_cut_i}
 elif [[ $data_dir_cut_i == *"EnMicroMsg"* ]];then
 chmod 0777 /data/data/com.tencent.mm/MicroMsg/${data_dir_i}/${data_dir_cut_i}
 fi
 done
fi
done

storage_dir_all=$(ls "/storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/")
for storage_dir_i in $storage_dir_all
do
if (( ${#storage_dir_i} > 30 )) && (( ${#storage_dir_i} < 34 ));then
storage_str=${storage_dir_i}
break
fi
done

if [[ $storage_str == "" ]];then
in_android="0"
tencent_dir_all=$(ls "/storage/emulated/0/${tencent}/MicroMsg/")
for tencent_dir_i in $tencent_dir_all
do
if (( ${#tencent_dir_i} > 30 )) && (( ${#tencent_dir_i} < 34 ));then
storage_str=${tencent_dir_i}
break
fi
done

fi


for storage_dir_i in $storage_dir_all
do
if (( ${#storage_dir_i} > 30 )) && (( ${#storage_dir_i} < 34 ));then
if [ -d /storage/emulated/0/WeChat_tmp/backup/image2  ];then
rm -rf /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/image2
fi
if [ -d /storage/emulated/0/WeChat_tmp/backup/voice2  ];then
rm -rf /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/voice2
fi
if [ -d /storage/emulated/0/WeChat_tmp/backup/video  ];then
rm -rf /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/video
fi
fi
done

for tencent_dir_i in $tencent_dir_all
do
if (( ${#tencent_dir_i} > 30 )) && (( ${#tencent_dir_i} < 34 ));then
if [ -d /storage/emulated/0/WeChat_tmp/backup/image2  ];then
rm -rf /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/image2
fi
if [ -d /storage/emulated/0/WeChat_tmp/backup/voice2  ];then
rm -rf /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/voice2
fi
if [ -d /storage/emulated/0/WeChat_tmp/backup/video  ];then
rm -rf /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/video
fi
fi
done

for data_dir_i in $data_dir_all
do
if (( ${#data_dir_i} > 30 )) && (( ${#data_dir_i} < 34 ));then
if [ -d /storage/emulated/0/WeChat_tmp/backup/image2  ];then
rm -rf /data/data/com.tencent.mm/MicroMsg/${data_dir_i}/image2
fi
fi
done


if [[ ${in_android} == 0 ]];then
storage_path="/storage/emulated/0/${tencent}/MicroMsg/${storage_str}/"
else
storage_path="/storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_str}/"
fi

if [ -d /storage/emulated/0/WeChat_tmp/backup/image2  ];then
echo "恢复图片中…"
cp -rf /storage/emulated/0/WeChat_tmp/backup/image2 ${storage_path}
echo "恢复图片成功！"
fi
if [ -d /storage/emulated/0/WeChat_tmp/backup/voice2  ];then
echo "恢复语音中…"
cp -rf /storage/emulated/0/WeChat_tmp/backup/voice2 ${storage_path}
echo "恢复语音成功！"
fi
if [ -d /storage/emulated/0/WeChat_tmp/backup/video  ];then
echo "恢复视频中…"
cp -rf /storage/emulated/0/WeChat_tmp/backup/video ${storage_path}
echo "恢复视频成功！"
fi

for recovery_dir_i in $recovery_dir_all
do
if (( ${#recovery_dir_i} > 30 )) && (( ${#recovery_dir_i} < 34 ));then
if [ -d ${storage_path}/image2  ];then
echo "恢复图片到data/data/中…"
ln -s ${storage_path}/image2 /data/data/com.tencent.mm/MicroMsg/${recovery_dir_i}/
echo "恢复图片到data/data成功！"
fi
fi
done

for storage_dir_i in $storage_dir_all
do
if (( ${#storage_dir_i} > 30 )) && [[ ${storage_dir_i} != ${storage_str} ]] && (( ${#storage_dir_i} < 34 ));then
if [ -d ${storage_path}/image2  ];then
echo "恢复图片到/Android/data中…"
ln -s ${storage_path}/image2 /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/
echo "恢复图片到/Android/data成功！"
fi
if [ -d ${storage_path}/voice2  ];then
echo "恢复语音到/Android/data中…"
ln -s ${storage_path}/voice2 /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/
echo "恢复语音到/Android/data成功！"
fi
if [ -d ${storage_path}/video  ];then
echo "恢复视频到/Android/data中…"
ln -s ${storage_path}/video /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/${storage_dir_i}/
echo "恢复视频到/Android/data成功！"
fi
fi
done

for tencent_dir_i in $tencent_dir_all
do
if (( ${#tencent_dir_i} > 30 )) && [[ ${tencent_dir_i} != ${storage_str} ]] && (( ${#tencent_dir_i} < 34 ));then
if [ -d ${storage_path}/image2  ];then
echo "恢复图片到/${tencent}中…"
ln -s ${storage_path}/image2 /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/
echo "恢复图片到/${tencent}成功！"
fi
if [ -d ${storage_path}/voice2  ];then
echo "恢复语音到/${tencent}中…"
ln -s ${storage_path}/voice2 /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/
echo "恢复语音到/${tencent}成功！"
fi
if [ -d ${storage_path}/video  ];then
echo "恢复视频到/${tencent}中…"
ln -s ${storage_path}/video /storage/emulated/0/${tencent}/MicroMsg/${tencent_dir_i}/
echo "恢复视频到/${tencent}成功！"
fi
fi
done

if [[ -d /storage/emulated/0/WeChat_tmp/backup/Download ]];then
echo "恢复下载的文件中…"
cp -rf /storage/emulated/0/WeChat_tmp/backup/Download /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/
if [[ -d /storage/emulated/0/${tencent}/MicroMsg/Download ]];then
cp -rLf /storage/emulated/0/${tencent}/MicroMsg/Download /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/ >> /dev/null 2>&1
rm -rf /storage/emulated/0/${tencent}/MicroMsg/Download
fi
ln -s /storage/emulated/0/Android/data/com.tencent.mm/MicroMsg/Download /storage/emulated/0/${tencent}/MicroMsg/
echo "下载的文件恢复完成"
fi

if [ -e /storage/emulated/0/WeChat_tmp/backup/KeyInfo.bin  ];then
cp -f /storage/emulated/0/WeChat_tmp/backup/KeyInfo.bin /data/data/com.tencent.mm/files/
chmod 0777 /data/data/com.tencent.mm/files/KeyInfo.bin
echo "恢复跨设备恢复关键文件成功！"
else
echo "恢复跨设备恢复关键文件失败！可能会导致无法恢复聊天记录！"
fi

rm -rf /storage/emulated/0/WeChat_tmp/
echo "恢复全部完成啦！！！"