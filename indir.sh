#!/usr/bin/env bash
# football-data.co.uk'ten bu sezon + geçen sezon lig dosyalarını ve gelecek maç listesini indirir.
# Bir dosya indirilemezse eskisi korunur.
set -u

KAYNAK="${KAYNAK:-https://www.football-data.co.uk}"
LIGLER="T1 E0 E1 SP1 I1 D1 F1 N1 P1 B1 SC0 G1"

yy=$((10#$(date -u +%y)))
ay=$((10#$(date -u +%m)))
if [ "$ay" -ge 7 ]; then bas=$yy; else bas=$((yy - 1)); fi
kod() { printf "%02d%02d" $(($1 % 100)) $((($1 + 1) % 100)); }
SEZONLAR="$(kod $bas) $(kod $((bas - 1)))"

indir() { # $1 = göreli yol
  local tmp="$1.tmp"
  mkdir -p "$(dirname "$1")"
  if curl -fsSL --retry 3 --retry-delay 5 -A "Mozilla/5.0" -o "$tmp" "$KAYNAK/$1" && [ -s "$tmp" ]; then
    mv "$tmp" "$1"
    echo "OK    $1 ($(wc -l < "$1") satir)"
  else
    rm -f "$tmp"
    echo "HATA  $1"
    hata=$((hata + 1))
  fi
}

hata=0
for s in $SEZONLAR; do
  for lig in $LIGLER; do indir "mmz4281/$s/$lig.csv"; done
done
indir fixtures.csv

echo "Son deneme: $(date -u '+%Y-%m-%d %H:%M') UTC, hatali dosya: $hata" > durum.txt
cat durum.txt
