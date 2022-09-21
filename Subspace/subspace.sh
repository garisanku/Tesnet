#!/bin/bash


echo "+============================================+"
echo -e "\033[41m __  __ ____          _    _   "
echo "|  \/  |  _ \   /\   | |  | |  "
echo "| \  / | |_) | /  \  | |__| |  "
echo "| |\/| |  _ < / /\ \ |  __  |  "
echo "| |  | | |_) / ____ \| |  | |  "
echo "|_|  |_|____/_/    \_|_|  |_|  "
echo -e "\033[31;47m _  ___      _______          ______  _   _ "
echo "| |/ | |    |_   _\ \        / / __ \| \ | |"
echo "|   /| |      | |  \ \  /\  / | |  | |  \| |"
echo "|  < | |      | |   \ \/  \/ /| |  | |     |"
echo "|   \| |____ _| |_   \  /\  / | |__| | |\  |"
echo -e "|_|\_|______|_____|   \/  \/   \____/|_| \_|\e[0m"
echo "+===========www.mbahkliwon.com===============+" && sleep 2

echo -e "\033[0;32m"
echo -e "+====================MENU====================+"
echo -e "Please Choose :"
echo -e "[1] Install Node"
echo -e "[2] Update Node"
echo -e "[3] Author"
echo -e "[4] Delete"
echo -e "[5] 18+ (adult)"
echo -e "[6] Exit"
echo -e "+============================================+"
read -p "Answer :" pil
echo -e "\e[0m"
if [ $pil = "1" ]
then
        echo -e "\e[1m\e[32m# Awas kereta lewat ( cuma sebentar ) \e[0m" && sleep 1
	sudo apt update
apt-get install sl

echo -e "\e[1m\e[32m# Perhatian Perhatian, Kereta jurusan  JAKARTA ~ SOLO mau melintas \e[0m" && sleep 3
echo -e "\e[1m\e[32m# Tuuuuut ~ Tuuuuut \e[0m" && sleep 2
sl && sleep 1

# set vars
echo -e "\e[1m\e[32mMasukkan node name dibawah ini dengan nama node kamu\e[0m"
if [ ! $NAMANODE ]; then
	read -p "Enter node name: " NAMANODE
	echo 'export NAMANODE='$NAMANODE >> $HOME/.bash_profile
fi
echo -e "\e[1m\e[32mMasukkan wallet address dibawah ini dengan account address dari akun subspace yang anda buat tadi\e[0m"
if [ ! $ADDRESS_SUBSPACE ]; then
	read -p "Enter wallet address: " ADDRESS_SUBSPACE
	echo 'export ADDRESS_SUBSPACE='$ADDRESS_SUBSPACE >> $HOME/.bash_profile
fi
echo -e "\e[1m\e[32mMasukkan plot size dalam gigabytes atau terabytes, untuk instance 100G atau 2T (tapi sisakan setidaknya 10G dari disk space untuk node)\e[0m"
echo -e "\e[1m\e[31mDefault plot size akan diatur menjadi 100 GB maximum (farmers mungkin akan mengubah plot size kurang dari 100 GB, tapi tidak lebih)\e[0m"
if [ ! $UKURAN_PLOT ]; then
	read -p "Enter plot size , max 100GB(ex. Format 100GB) : " UKURAN_PLOT
	echo 'export UKURAN_PLOT='$UKURAN_PLOT >> $HOME/.bash_profile
fi
source ~/.bash_profile

echo '================================================='
echo -e "Your node name: \e[1m\e[32m$NAMANODE\e[0m"
echo -e "Your wallet name: \e[1m\e[32m$ADDRESS_SUBSPACE\e[0m"
echo -e "Your plot size: \e[1m\e[32m$UKURAN_PLOT\e[0m"
echo -e '================================================='
sleep 3

echo -e "\e[1m\e[32m1. Updating packages... \e[0m" && sleep 1
# update packages
sudo apt update && sudo apt upgrade -y

echo -e "\e[1m\e[32m2. Installing dependencies... \e[0m" && sleep 1
# update dependencies
sudo apt install curl jq ocl-icd-opencl-dev libopencl-clang-dev libgomp1 -y

# update executables
cd $HOME
rm -rf subspace-*
APP_VERSION=$(curl -s https://api.github.com/repos/subspace/subspace/releases/latest | jq -r ".tag_name" | sed "s/runtime-/""/g")
wget -O subspace-node https://github.com/subspace/subspace/releases/download/${APP_VERSION}/subspace-node-ubuntu-x86_64-${APP_VERSION}
wget -O subspace-farmer https://github.com/subspace/subspace/releases/download/${APP_VERSION}/subspace-farmer-ubuntu-x86_64-${APP_VERSION}
chmod +x subspace-*
mv subspace-* /usr/local/bin/

echo -e "\e[1m\e[32m4. Starting service... \e[0m" && sleep 1
# create subspace-node service 
tee $HOME/subspaced.service > /dev/null <<EOF
[Unit]
Description=Subspace Node
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=$(which subspace-node) --chain gemini-2a --execution wasm --state-pruning archive --validator --name $NAMANODE
Restart=on-failure
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

# create subspaced-farmer service 
tee $HOME/subspaced-farmer.service > /dev/null <<EOF
[Unit]
Description=Subspaced Farm
After=network.target
[Service]
User=$USER
Type=simple
ExecStart=$(which subspace-farmer) farm --reward-address $ADDRESS_SUBSPACE --plot-size $UKURAN_PLOT
Restart=on-failure
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

mv $HOME/subspaced* /etc/systemd/system/
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable subspaced subspaced-farmer
sudo systemctl restart subspaced
sleep 30
sudo systemctl restart subspaced-farmer
sleep 5

elif [ $pil = "2" ]
then
	echo -e "\033[31m"
        echo "Not Working For Now !!!"
        echo -e "\e[0m"
        sleep 1 && bash logo.sh

elif [ $pil = "3" ]
then
	clear
	echo "====================MENU===================="
	echo "[+] Twitter  : @oxkliwon"
	echo "[+] Telegram : @Embahkliwon"
	echo "[+] Discord  : Mbah Kliwon#0184"
	echo "[+] GitHub   : https://github.com/garisanku"
	echo "============================================"
	echo " "
	echo -e "\033[31m"
        echo "Will return to main menu within 5 seconds"
        echo -e "\e[0m"
        sleep 10 && bash logo.sh

elif [ $pil = "4" ]
then 
	echo -e "\033[31m"
        echo "Not Working For Now !!!"
        echo -e "\e[0m"
        sleep 1 && bash logo.sh


elif [ $pil = "5" ]
then
        clear
		echo "_________________¶¶111111¶11111111111111¶¶111¶____"
echo "_________________¶¶11111¶111111111111111¶¶111¶____"
echo "________________¶¶111111¶11111111¶¶11¶¶¶¶1111¶____"
echo "_______________¶¶1111111111111111¶¶¶¶¶¶¶11111¶____"
echo "_____________1¶¶11111111111111111¶¶___¶¶11111¶____"
echo "___________¶¶¶¶11111¶1111111¶¶1111¶¶¶11¶11111¶____"
echo "_________¶¶¶111111111111111111111111¶¶¶¶11111¶____"
echo "_______1¶¶11111111111111111111111111111¶¶¶111¶____"
echo "______¶¶111111111111111111111111111111111¶¶¶1¶____"
echo "_____¶¶1111111111111111¶11¶¶111111111111111¶¶¶____"
echo "____¶¶11111111111111111¶¶¶¶11111111111111111¶¶____"
echo "___¶¶1111111111111111111¶¶1111111111111111111¶¶___"
echo "__¶¶11111111111111111111¶¶11111111111111111111¶¶__"
echo "__¶111111111111111111111¶1111111111111111111111¶__"
echo "_¶¶11111111111111111111¶¶1111111111111111111111¶¶_"
echo "_¶111111111111111111111¶¶1111111111111111111111¶¶_"
echo "_¶111111111111111111111¶¶1111111111111111111111¶¶_"
echo "1¶111111111111111111111¶¶1111111111111111111111¶¶_"
echo "1¶111111111111111111111¶¶1111111111111111111111¶¶_"
echo "1¶111111111111111111111¶¶1111111111111111111111¶1_"
echo "_¶1111111111111111111111¶¶11111111111111111111¶¶__"
echo "_¶1111111111111111111111¶¶11111111111111111111¶1__"
echo "_¶111111111111111111111¶¶¶¶111111111111111111¶¶___"
echo "_¶¶1111111111111111111¶¶1¶¶¶¶111111111111111¶¶____"
echo "_1¶1111111111111111¶¶¶¶¶¶¶¶¶¶¶¶111111111111¶¶1____"
echo "__¶11111111111¶¶¶¶¶¶¶¶¶¶¶_¶¶¶¶¶¶¶¶¶¶¶11111¶¶¶1____"
echo "__¶¶1111111111¶¶¶¶11111¶¶_¶¶1111¶¶¶¶1111¶¶¶1¶¶____"
echo "__1¶¶¶11111111111111111¶¶_¶1¶1111111111¶¶¶11¶¶____"
echo "___¶¶¶¶¶1111111111111111¶¶¶¶1111111111¶¶_¶_1¶¶____"
echo "___1¶111¶¶¶11111111111111¶¶¶¶111111¶1¶¶_1¶_11¶____"
echo "____¶¶1111¶¶¶111111111111¶¶¶1111111¶¶¶_¶¶1111¶____"
echo "____1¶111111¶¶¶1111111111¶1¶¶1111111¶¶¶11¶11¶¶____"
echo "_____¶¶1111111¶¶¶¶1111111¶¶¶¶111111111¶1¶¶_1¶¶____"
echo "_____1¶1111111111¶¶¶¶1111¶¶1¶¶11111111¶¶¶¶_1¶1____"
echo "______¶¶11111111111¶¶¶¶111¶1¶¶111111111¶¶¶__¶1____"
echo "______1¶11111111111111¶¶¶¶¶_1¶1111111111¶¶111¶____"
echo "_______¶¶111111111111111¶¶¶1¶¶1111111111¶¶¶¶¶¶1___"
echo "________¶111111111111111¶¶__1¶¶¶11111111¶¶¶1¶¶¶___"
echo "________¶¶111111111111111¶1__1¶1¶¶¶¶¶1111¶¶¶¶¶¶1__"
echo "_________¶111111111111111¶¶___¶111¶¶¶¶¶¶¶¶¶¶_1¶___"
echo "_________¶¶11111111111111¶¶___¶¶1111111¶¶¶____¶___"
echo "__________¶1111111111111¶¶_____¶111111111¶________"

		sleep 3 && clear && ./logo.sh

elif [ $pil = "6" ]
then
        exit

else
        echo -e "\033[31m"
        echo "Your answer is wrong !!!! "
        echo -e "\e[0m"
        sleep 1 && bash logo.sh

fi
