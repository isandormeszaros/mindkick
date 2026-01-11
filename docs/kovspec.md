# Követelmény Specifikáció – MindKick Quiz Platform

## 1. Áttekintés

A fejlesztői csapatunk azt a feladatot tűzte ki célul, hogy létrehozzon egy modern, webes alapú kvízalkalmazást, a **MindKick**-et. A szoftver célja, hogy interaktív és szórakoztató módon tegye lehetővé a tudásfelmérést a felhasználók számára, miközben a gamifikáció (játékosítás) eszközeivel – például pontgyűjtés és ranglista – motiválja őket.

A rendszer nemcsak a játékosokra koncentrál: kiemelt figyelmet fordítunk az adminisztrátorokra is, akiknek egy könnyen kezelhető felületet biztosítunk a kvízek teljes körű menedzselésére (létrehozás, törlés, szerkesztés), mindezt programozói tudás nélkül.

Célunk, hogy a tanulás és a versengés egy gyors, reszponzív és felhasználóbarát környezetben valósuljon meg.

---

## 2. Jelenlegi helyzet

A tudásfelmérés jelenleg sok esetben statikus, unalmas módszerekkel történik (papíralapú tesztek, egyszerű Google űrlapok vagy elavult, lassú rendszerek). Ezek a megoldások:

* Nem adnak azonnali visszajelzést
* Hiányzik belőlük a vizualitás
* Nem ösztönzik a felhasználót a fejlődésre
* Nincs ranglista vagy összehasonlítási alap

Adminisztrációs oldalról a karbantartás gyakran manuális adatbázis-módosítást igényel, ami:

* Lassú
* Hibalehetőségekkel teli
* „Árva” adatokat hagyhat maga után (pl. kérdések kvíz nélkül)

A felhasználók sokszor nem találják meg a megfelelő nehézségi szintet, mivel:

* A tartalmak ömlesztve jelennek meg
* Nincsenek szűrési lehetőségek

---

## 3. Vágyálom rendszer

A cél egy olyan dinamikus webalkalmazás, ahol a **felhasználói élmény áll a középpontban**.

### Fő jellemzők

* Gyors regisztráció és bejelentkezés
* Kvízek böngészése téma és nehézség szerint (Easy / Medium / Hard)
* Nehézségi szinthez igazított időkorlát
* Vizuális visszajelzések (villogó óra, színes eredmények)
* Azonnali eredményértékelés
* Globális ranglista (Leaderboard)

### Admin funkciók

* Védett admin felület
* Grafikus kvízlétrehozás
* Biztonságos törlés
* Automatikus adat-takarítás (kérdések, válaszok)

A rendszer:

* Stabil
* Gyors
* Mobilon, tableten és asztali gépen is tökéletesen működik

---

## 4. Jelenlegi üzleti folyamatok modellje

A hagyományos rendszerek jellemzői:

* Egyirányú, merev tesztkitöltés
* Késleltetett vagy minimális visszajelzés
* Nincs kontextus vagy összehasonlítás
* Nincs visszatérési motiváció

Admin oldalon:

* Fejlesztői beavatkozás szükséges módosításokhoz
* Hiányos jogosultságkezelés
* Terhelés esetén adatvesztés kockázata

Mobilos használat gyakran:

* Rosszul optimalizált
* Szétcsúszó UI
* Nehezen olvasható tartalom

---

## 5. Igényelt üzleti folyamatok modellje

A **MindKick** egy modern technológiai stackre épül:

* **Frontend:** React
* **Backend:** Node.js
* **Adatbázis:** MySQL

### Tanulók / Játékosok

* Bejelentkezés után kvízek szűrése
* Valós idejű pontszámítás
* Időzítő kezelése
* Eredmények automatikus mentése
* Ranglista frissítése

### Adminisztrátorok

* Dedikált admin jogkör
* Kvízek létrehozása pár kattintással
* Kaszkádolt törlés (kapcsolódó adatok automatikus eltávolítása)

### Biztonság

* JWT token alapú hitelesítés
* Hamis eredmények beküldésének kizárása

### Fő funkciók

* Regisztráció és belépés
* Kvízek böngészése
* Dinamikus játékfelület
* Admin Dashboard
* Ranglista (Leaderboard)
* Profil és statisztika (XP, kitöltések száma)

---

## 6. Követelménylista

| ID  | Modul              | Név                  | Kifejtés                                                               |
| --- | ------------------ | -------------------- | ---------------------------------------------------------------------- |
| K1  | Weboldal           | Főoldal és navigáció | Reszponzív kialakítás, mobilbarát menü, figyelemfelkeltő kezdőképernyő |
| K2  | Weboldal           | Kvízlista            | Kártyás megjelenítés, szűrés nehézség szerint                          |
| K3  | Felhasználókezelés | Autentikáció         | Regisztráció, belépés, JWT alapú munkamenet                            |
| K4  | Játékmenet         | Kvíz motor           | Kérdésléptetés, válaszértékelés, időzítő                               |
| K5  | Adminisztráció     | Kvíz létrehozása     | Űrlap kvíz, kérdések és válaszok felvitelére                           |
| K6  | Adminisztráció     | Kvíz törlése         | Kaszkádolt, biztonságos törlés                                         |
| K7  | Gamifikáció         | Ranglista            | Pontszám alapú sorrend, vizuális kiemelés                              |
| K8  | Adatbázis          | Statisztika          | XP és kitöltések perzisztens tárolása                                  |
| K9  | Weboldal           | UI / UX              | Modern dizájn (Tailwind), vizuális visszajelzések                      |
| K10 | Biztonság          | Jogosultságkezelés   | Admin és User jogkörök szétválasztása                                  |

---

## 7. Fogalomtár

**Szoftver (Webalkalmazás)**
Böngészőben futó, telepítést nem igénylő program, amely kliens–szerver kommunikációra épül.

**Gamifikáció (Játékosítás)**
Játékos elemek (pontok, ranglisták, szintek) alkalmazása a motiváció növelése érdekében.

**Reszponzivitás**
Az oldal automatikus alkalmazkodása a különböző képernyőméretekhez.

**Kaszkádolt törlés (Cascade Delete)**
Adatbázis-művelet, ahol a főelem törlésével az összes kapcsolódó al-elem is eltávolításra kerül.

**JWT (JSON Web Token)**
Biztonságos azonosítási mechanizmus a kliens és szerver között.

**XP (Experience Points)**
Tapasztalati pont, amely a felhasználó teljesítményét méri a rendszerben.
