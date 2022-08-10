#!/bin/bash
clear && sleep 1

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
echo -e "[1] Install Sui | source code"
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

	sleep 1
	echo -e "\e[1m\e[32m1. Pembaruan paket... \e[0m" && sleep 1
	sudo apt update && sudo apt upgrade -y

	echo -e "\e[1m\e[32m2. Instal paket yang diperlukan... \e[0m" && sleep 1
	sudo apt install wget jq git libclang-dev cmake -y

	echo -e "\e[1m\e[32m3. Instal Rust... \e[0m" && sleep 1
	wget -qO- https://raw.githubusercontent.com/SecorD0/utils/main/installers/rust.sh

	echo -e "\e[1m\e[32m4. Buat direktori sui& clone repo... \e[0m" && sleep 1
	mkdir -p $HOME/.sui
	git clone https://github.com/MystenLabs/sui
	cd sui
	git remote add upstream https://github.com/MystenLabs/sui && git fetch upstream && git checkout --track upstream/devnet

	echo -e "\e[1m\e[32m5. Build file bineri (kecepatan tergantung core prosesor, mungkin memakan waktu 10 menit).. \e[0m" && sleep 1
	version=`wget -qO- https://api.github.com/repos/SecorD0/Sui/releases/latest | jq -r ".tag_name"`; \
	wget -qO- "https://github.com/SecorD0/Sui/releases/download/${version}/sui-linux-amd64-${version}.tar.gz" | tar -C /usr/bin/ -xzf -

	echo -e "\e[1m\e[32m7. Download Genesis File.. \e[0m" && sleep 1
	wget -qO $HOME/.sui/genesis.blob https://github.com/MystenLabs/sui-genesis/raw/main/devnet/genesis.blob

	echo -e "\e[1m\e[32m8. Copy config.. \e[0m" && sleep 1
	cp $HOME/sui/crates/sui-config/data/fullnode-template.yaml \
	$HOME/.sui/fullnode.yaml

	echo -e "\e[1m\e[32m9. Edit config.. \e[0m" && sleep 1
sed -i -e "s%db-path:.*%db-path: \"$HOME/.sui/db\"%; "\
"s%metrics-address:.*%metrics-address: \"0.0.0.0:9184\"%; "\
"s%json-rpc-address:.*%json-rpc-address: \"0.0.0.0:9000\"%; "\
"s%genesis-file-location:.*%genesis-file-location: \"$HOME/.sui/genesis.blob\"%; " $HOME/.sui/fullnode.yaml

	echo -e "\e[1m\e[32m10. Buat file service.. \e[0m" && sleep 1
	printf "[Unit]
	Description=Sui node
	After=network-online.target
	[Service]
	User=$USER
	ExecStart=`which sui-node` --config-path $HOME/.sui/fullnode.yaml
	Restart=on-failure
	RestartSec=3
	LimitNOFILE=65535
	[Install]
	WantedBy=multi-user.target" > /etc/systemd/system/suid.service

	echo -e "\e[1m\e[32m11. Mulai menjalankan node.. \e[0m" && sleep 1
	sudo systemctl daemon-reload
	sudo systemctl enable suid
	sudo systemctl restart suid
	
	echo -e "\e[1m\e[32m12. Cek node status \e[0m" && sleep 1
	curl -s -X POST http://127.0.0.1:9000 -H 'Content-Type: application/json' -d '{ "jsonrpc":"2.0", "method":"rpc.discover","id":1}' | jq .result.info
	
	echo -e "\e[1m\e[32m13. Cek 5 TX terakhir \e[0m" && sleep 1
	curl --location --request POST 'http://127.0.0.1:9000/' --header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "id":1, "method":"sui_getRecentTransactions", "params":[5] }' | jq .

	echo -e "\e[1m\e[32m14. Dapatkan detail tx \e[0m" && sleep 1
	curl --location --request POST 'http://127.0.0.1:9000/' --header 'Content-Type: application/json' \
--data-raw '{ "jsonrpc":"2.0", "id":1, "method":"sui_getTransaction", "params":["<RECENT_TXN_FROM_ABOVE>"] }' | jq .
	
	echo -e "\e[1m\e[32m# BUAT WALLET SUI \e[0m" && sleep 5
	echo -e "y\n" | sui client
	sleep 1
	sui client switch --gateway https://gateway.devnet.sui.io:443
	sleep 1
	echo -e "\e[1m\e[32m# Ini wallet mu \e[0m" && sleep 1
	sui client active-address
	sleep 5
	
	echo -e "\e[1m\e[32m# Update Fullnode \e[0m" && sleep 5
	wget -qO update_sui_source.sh https://raw.githubusercontent.com/garisanku/tesnet/main/Update/update_sui_source.sh && chmod +x update_sui_source.sh && ./update_sui_source.sh
	
	echo -e "\e[1m\e[32m# DONE | cek your IP https://node.sui.zvalid.com \e[0m" && sleep 5
	
	
	
	
elif [ $pil = "2" ]
then
	wget -qO update_sui_source.sh https://raw.githubusercontent.com/garisanku/tesnet/main/Update/update_sui_source.sh && chmod +x update_sui_source.sh && ./update_sui_source.sh
        sleep 1 && bash sui.sh

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
        sleep 10 && bash sui.sh

elif [ $pil = "4" ]
then 
	echo -e "\033[31m"
        echo "Not Working For Now !!!"
        echo -e "\e[0m"
        sleep 1 && bash sui.sh


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

		sleep 3 && clear && ./sui.sh

elif [ $pil = "6" ]
then
        exit

else
        echo -e "\033[31m"
        echo "Your answer is wrong !!!! "
        echo -e "\e[0m"
        sleep 1 && bash sui.sh

fi
