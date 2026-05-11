````markdown
# BHEH ning XSSRocket

<p align="center">
<a href="https://www.blackhatethicalhacking.com"><img src="https://www.blackhatethicalhacking.com/wp-content/uploads/2022/06/BHEH_logo.png" width="300px" alt="BHEH"></a>
</p>

<p align="center">
XSS Rocket, Black Hat Ethical Hacking tomonidan yozilgan bo'lib, hujumga qarshi xavfsizlik va XSS (Sayt-ichasidagi skriptlar) hujumlari uchun mo'ljallangan.

Rahmat va hurmat <a href="https://github.com/shadowdevnotreal"> ShadowDevnotreal ga

</p>

# Tavsifi

XSS Rocket, **Wayback Machine** dan URL larni olib kelib, ularni URL da mavjud bo'lgan parametrlar asosida filtrlaydi. Keyin **httpx** bilan URL larni filtrlaydi, bir nechta **Grep** va **SED**dan foydalanib [...]

Bundan tashqari, u **xususiyatni** o'z ichiga oladi, bu **Hujumga qarshi xavfsizlik uchun tasodifiy Sun Tzu iqtibosni** yaratadi va natijalarni ko'rsatish uchun lolcat va ASCII art dan foydalanadi va foydalanuvchini tekshirish tizimini ta'minlaydi [...]

Bu vositani maxsus qiladigan narsа bu **metodologiya** va **tanqidiy fikrlash** hisoblanadi, chunki u har bir qadamda nima qilayotganini, lekin payloadvordni o'zgartirib, [...]

# So'nggi Versiya & Yangilanishlar:

• V2 endi natijalarni har qanday emailga yuborish imkonini beradi, siz konfiguratsiyani o'rnatish uchun o'zingizning SMTP ma'lumotlarini skriptni tahrirlash va ma'lumotlarni qo'shish orqali foydalanishingiz mumkin.

• Ishlashda ba'zi sozlamalar va yaxshilanishlar

# Xususiyatlari:

• Proxychains dan foydalanib Shirinlik Rejimini qo'llab-quvvatlaydi, dastlabki mexanizmaga qarshi hujumlar uchun yanada ishonchli

• Wayback Machinedan avtomatik ravishda URL larni olib keladi

• URL larda mavjud bo'lgan parametrlar asosida URL larni filtrlaydi

• Faqat tirik URL larni filtrlash va har bir parametr uchun qiymatlarni tozalash uchun httpx dan foydalanadi

• GitHub dan masofadan XSS payload ro'yxatini ishlatadi

• Arxitekturaga qarab barcha kerakli talablarni o'rnatadi va yangi yangilanishlarni oladi (MacOS, Ubuntu, Debian, Kali bilan mos)

• URL larga payload ro'yxati bilan GET so'rovlarini yuboradi

• Mumkin bo'lgan XSS zaifliklarini aniqlaydi va hisobot qiladi

• Natijalarni saqlash uchun domen nomi bilan papka yaratadi

• Mumkin bo'lgan ranjavur URL lar soni va Xulosa bilan yakuniy xabarni chop qiladi

• Natija URL larini faylda saqlaydi

• Hujumga qarshi xavfsizlik uchun tasodifiy Sun Tzu iqtibosini ko'rsatadi

• Vositani ishlatishdan oldin foydalanuvchining Internetga ulanganligini tekshiradi

• Payload larni URL larni qo'shishning usulini taqdim etadi

• Payload bilan to'liq URL ni chiqaradi

**Bu vosita, shuningdek, topilgan mumkin bo'lgan XSS injectionlar jami sonini, ranjavur URL lar, ishlatilgan payload va javob kodi ro'yxatini ko'rsatadigan xulosa xususiyatini ko'rsatadi, [...]

Bu sizga xatoni ov paytida mukofot olishda yordam beradi:

![giphy-3](https://user-images.githubusercontent.com/13942386/220473071-db3d1fa8-bec7-47ce-9b46-9a8a8ed123e9.gif)


# Talablar:

• waybackurls: Bu vositani go install github.com/tomnomnom/waybackurls@latest ni ishlatib o'rnata olasiz

• cURL: Bu vosita odatda Kali Linux va Ubuntu da o'rnatilgan, lekin Ubuntu da apt-get install curl yoki MacOS da brew install curl ni ishlatib o'rnatish mumkin

• figlet: Bu vositani Kali Linux yoki Ubuntu da apt-get install figlet ni ishlatip yoki MacOS da brew install figlet ni ishlatib o'rnata olasiz

• lolcat: Bu vositani gem install lolcat ni ishlatib o'rnata olasiz

• wget: Bu vosita odatda Kali Linux va Ubuntu da o'rnatilgan, lekin Ubuntu da apt-get install wget ni yoki MacOS da brew install wget ni ishlatib o'rnata olasiz

# O'rnatish

```bash
git clone https://github.com/blackhatethicalhacking/XSSRocket.git
cd XSSRocket
chmod +x XSSRocket.sh
./XSSRocket.sh
```

# Skrinshot

**Asosiy Menyusi**

![Capture](https://github.com/user-attachments/assets/f4698248-e08c-4dac-95b3-26853154d898)



# Mos kelish: 

Bu vosita Kali Linux, Ubuntu va MacOS da sinov qilingan.

# Payload Wordlist:

Payload ro'yxatini o'zgartirish uchun vositani tahrirlashingiz va boshqa URL ni o'rnatishingiz mumkin.


# Inobat Qabul Qilish

Bu vosita faqat o'quv va tadqiqot maqsadlari uchun taqdim qilinadi. Ushbu loyihaning muallifi bu vositaning hech qanday noto'g'ri qo'llanishi uchun mas'ul emas.

Biz uni NDA kelishuvlari bo'yicha va ularning klient tomonidan pentesting maqsadlari uchun roziligi bilan sinab ko'ramiz va biz hech qachon noto'g'ri qo'llashni rag'batlantirilmay va yoki yuz bergan zararni sudbatiga olamiz!

<h2 align="center">
  <a href="https://store.blackhatethicalhacking.com/" target="_blank">BHEH Rasmiy Merch Magazini</a>
</h2>

<p align="center">
Hujumga qarshi xavfsizlik hamjamiyati uchun mo'ljallangan bizning Merch Magazini. Ommaviy va tajribali foydalanuvchilar uchun joyda yaxshi kiyim va ichimlik to'plamlari. Bizning tanlovimiz [...]
Hacker uslubida yangi jihati bilan va xaker madaniyatiga sodiqlikni ko'rsating, shunday vosita bilan, bu dinamik va mustahkam siz kabilasiz. 😊
</p>

<p align="center">

<img src="https://github.com/blackhatethicalhacking/blackhatethicalhacking/blob/main/Merch_Promo.gif" width="540px" height="540">
  </p>
````
