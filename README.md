# BHEH ning XSSRocket

<p align="center">
<a href="https://www.blackhatethicalhacking.com"><img src="https://www.blackhatethicalhacking.com/wp-content/uploads/2022/06/BHEH_logo.png" width="300px" alt="BHEH"></a>
</p>

<p align="center">
XSS Rocket - Black Hat Ethical Hacking tomonidan yaratilgan bo'lib, Hujumga qarshi xavfsizlik va XSS (Cross-Site Scripting) hujumlar uchun mo'ljallangan.

Rahmat <a href="https://github.com/shadowdevnotreal">ShadowDevnotreal</a> ga

</p>

# Tavsifi

XSS Rocket **Wayback Machine** dan URL larni oladi va ularni URL da mavjud bo'lgan parametrlar asosida filtr qiladi. Keyin **httpx** dan foydalanib, **Grep** va **SED** qo'llab-quvvatlash bilan URL larni filtrlaydi.

Bu vosita **Offensive Security uchun tasodifiy Sun Tzu iqtiboslari** yaratish xususiyatini o'z ichiga oladi va lolcat qo'llanib rangli chiqarish va ASCII art ni ko'rsatadi hamda foydalanuvchi tekshiruvi tizimiga ega.

Bu vosita nima bilan maxsusdir - bu **metodologiya** va har bir harakat uchun ortasida **kritik fikrlash** dir, shuningdek payload sozlamasi orqali o'zgarish kiritish imkoniyatidir.

# Oxirgi Versiya va Yangilanishlar:

• V2 endi natijalarni istalgan emailga yuborish qo'llab-quvvataydi, SMTP ushbu faylni o'zgartirib konfiguratsiya qilish uchun skriptni tahrirlash orqali o'zingizning ma'lumotlarini qo'shishingiz mumkin.

• Ishlashni tezlashtirish va qayta takomillashtirish

# Xususiyatlari:

• Proxychains dan foydalanib, Stealth rejimini qo'llaydi, hujumlar uchun himoyalash mexanizmlari bilan ishlaydi

• Wayback Machine dan avtomatik URL larni yuklaydi

• URL dagi parametrlar asosida URL larni filtrlaydi

• httpx qo'llanib, faqat faol URL larni filtrlaydi va har bir parametr uchun qiymatlarni tozalaydi

• Github dan masofadan XSS payload ro'yxatini qo'llaydi

• Arxitektura asosida zarur bo'lgan barcha modullarni o'rnatadi va yangi yangilashlarni qabul qiladi (MacOS, Ubuntu, Debian, Kali bilan uyumli)

• URL lardan payload ro'yxati bilan GET so'rovlarini yuboradi

• Mumkin bo'lgan XSS zaifligini aniqlaydi va hisobot qiladi

• Domain nomi bilan papka yaratadi va natijalarni saqlaydi

• Xulosa habar bilan topilgan mumkin bo'lgan ranjavur URL lar va xulosa raqamini chop qiladi

• Natija URL larni faylda saqlaydi

• Offensive security uchun tasodifiy Sun Tzu iqtibosini ko'rsatadi

• Aslida qo'llanish oldin Internet ulanishini tekshiradi

• URL lardan payload qo'shish usulini ta'minlaydi

• Payload bilan to'liq URL ni chiqaradi

**Bu vosita umumiy XSS injectionlarini topish soni, ta'sirlangan URL lar ro'yxati, foydalanilgan payload va javob kodi qo'llangan xulosa xususiyati ham ko'rsatadi.**

Bu sizga bug bounty olib chiqishga yordam beradi:

![giphy-3](https://user-images.githubusercontent.com/13942386/220473071-db3d1fa8-bec7-47ce-9b46-9a8a8ed123e9.gif)


# Talablar:

• waybackurls: Bu vositani `go install github.com/tomnomnom/waybackurls@latest` orqali o'rnatish mumkin

• cURL: Bu vosita Kali Linux va Ubuntu da odatiy o'rnatilgan, lekin Ubuntu da `apt-get install curl` yoki MacOS da `brew install curl` orqali o'rnatilishi mumkin

• figlet: Bu vositani Kali Linux yoki Ubuntu da `apt-get install figlet` yoki MacOS da `brew install figlet` orqali o'rnatish mumkin

• lolcat: Bu vositani `gem install lolcat` orqali o'rnatish mumkin

• wget: Bu vosita Kali Linux va Ubuntu da odatiy o'rnatilgan, lekin Ubuntu da `apt-get install wget` yoki MacOS da `brew install wget` orqali o'rnatilishi mumkin

# O'rnatish

```bash
git clone https://github.com/VIPOS-testuser/XSSRocket.git
cd XSSRocket
chmod +x XSSRocket.sh
./XSSRocket.sh
```

# Skrinshot

**Asosiy Menyu**

![Capture](https://github.com/user-attachments/assets/f4698248-e08c-4dac-95b3-26853154d898)


# Uyumlilik:

Bu vosita Kali Linux, Ubuntu va MacOS da sinab o'tkazilgan.

# Payload Lug'ati:

Payload ro'yxatini o'zgartirish uchun vositani tahrirlab, boshqa URL ni o'rnatishingiz mumkin.


# Inobat Qabul Qilish

Bu vosita faqat ta'lim va tadqiqot maqsadlari uchun taqdim etiladi. Bu loyihaning muallifi ushbu vositaning noto'g'ri ishlatilinishidan hech qanday javobgarlilik olmaydi.

Biz NDA shartnomalari va kliyentlarning roziligida pentesting maqsadlari uchun sinab o'tkazamiz va noto'g'ri ishlatilinishni taqosamiz yoki har qanday zarar uchun javobgarlik olmaimiz!

<h2 align="center">
  <a href="https://store.blackhatethicalhacking.com/" target="_blank">BHEH Rasmiy Sovrin Do'koni</a>
</h2>

<p align="center">
Offensive Security jamiyati uchun mo'ljallangan Merch do'konimizga xush kelibsiz. Har bir professional va ishtirokchilarga qulay bo'lgan ko'ylak va ichish idishlari to'plamini ko'rib chiqing. Bizning tanlangan kolleksiyasida xaker madaniyatiga mos va dinamik hamda mustahkam sizning uslubingiz sifatida mavjud.

Hacker uslubi bilan ishlang va "BHEH Rasmiy Merch" bilan xaker madaniyatiga sadoqat qilishingizni ko'rsating! 😊
</p>

<p align="center">

<img src="https://github.com/blackhatethicalhacking/blackhatethicalhacking/blob/main/Merch_Promo.gif" width="540px" height="540">
  </p>
